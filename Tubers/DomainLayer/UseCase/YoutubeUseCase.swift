//
//  YoutubeUseCase.swift
//  Tubers
//
//  Created by mmsc on 2018/12/08.
//  Copyright © 2018年 mmsc. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

/*
 - ユースケースに必要なロジック処理を記述する
 - どのデータをどのように取得するかここで実装する
 - UIには直接関与しない(View,ViewControllerから直接参照されない)
*/

class YoutubeUseCase {

    let youTubeListURL = "https://www.googleapis.com/youtube/v3/search?part=snippet&maxResults=40&order=date&type=video&key="
    
    let searchChannelURL = "https://www.googleapis.com/youtube/v3/search?type=video&part=snippet&maxResults=40&order=date&q="
    
    // Youtube一覧
    var youtubeList = YouTubeList()
    
    // 初回取得
    var isFirst = true
    
    private let eventSubject = PublishSubject<Int>()
    var event: Observable<Int> { return eventSubject }
    
    // 新着一覧
    func loadYouTubeList(nextPageToken: String = "") {
        
        let apiManager = APIManager()
        
        let url = nextPageToken != "" ? youTubeListURL + TubersKeys().youtubeAPIKey + "&pageToken=" + nextPageToken : youTubeListURL + TubersKeys().youtubeAPIKey
                
        apiManager.ConnectionAPI(url: url, success: {(result: Data) -> Void in
            
            let decoder: JSONDecoder = JSONDecoder()
            do {
                // 初回取得の場合
                if self.isFirst {
                    self.youtubeList = try decoder.decode(YouTubeList.self, from: result)
                    self.isFirst = false
                } else {
                    // 2回目以降
                    let list: YouTubeList = try decoder.decode(YouTubeList.self, from: result)
                    
                    guard let appendItem = list.items, appendItem.count != 0 else {
                        self.eventSubject.onCompleted()
                        return
                    }
                    
                    // 続きを取得するためのトークンを設定
                    self.youtubeList.nextPageToken = list.nextPageToken
                    
                    // youtubeListに追加
                    let _ = appendItem.map({ self.youtubeList.items?.append($0) })
                }
                self.eventSubject.onNext(1)
            } catch {
                print("json convert failed in JSONDecoder", error.localizedDescription)
            }
        }, failure: {(result: Error?) -> Void in
            
        })
    }
    
    // 検索
    func searchChannel(word: String, nextPageToken: String = "") {
        
        let apiManager = APIManager()
        
        let url = nextPageToken != "" ? searchChannelURL + word + "&key=" + TubersKeys().youtubeAPIKey + "&pageToken=" + nextPageToken : searchChannelURL + word + "&key=" + TubersKeys().youtubeAPIKey

        apiManager.ConnectionAPI(url: url, success: {(result: Data) -> Void in
            
            let decoder: JSONDecoder = JSONDecoder()
            do {
                // 初回取得の場合
                if self.isFirst {
                    self.youtubeList = try decoder.decode(YouTubeList.self, from: result)
                    self.isFirst = false
                } else {
                    // 2回目以降
                    let list: YouTubeList = try decoder.decode(YouTubeList.self, from: result)
                    
                    guard let appendItem = list.items, appendItem.count != 0 else {
                        self.eventSubject.onCompleted()
                        return
                    }
                    
                    // 続きを取得するためのトークンを設定
                    self.youtubeList.nextPageToken = list.nextPageToken
                    
                    // youtubeListに追加
                    let _ = appendItem.map({ self.youtubeList.items?.append($0) })
                }
                self.eventSubject.onNext(1)
            } catch {
                print("json convert failed in JSONDecoder", error.localizedDescription)
            }
        }, failure: {(result: Error?) -> Void in
            
        })
    }
}
