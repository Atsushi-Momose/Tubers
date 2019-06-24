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

enum searchType: Int {
    case newArrival = 1// 新着
    case textSearch // 検索
    case channelSearch // 特定のチャンネル検索
}

class YoutubeUseCase {
    
    // Youtube一覧
    var youtubeList = YouTubeList()
    
    // 初回取得
    var isFirst = true
    
    private let eventSubject = PublishSubject<Int>()
    var event: Observable<Int> { return eventSubject }
    
    func xxx(searchType: searchType, searchWord: String, channelID: String) {
        let apiConstants = APIConstants()
        let youtubeAPIKey = String(TubersKeys().youtubeAPIKey())
        let nextPageToken = self.youtubeList.nextPageToken
        var searchURL = String()
        
        switch searchType {
        case .newArrival:
            if self.youtubeList.nextPageToken != nil && nextPageToken != "" {
                searchURL = (String(format: apiConstants.youTubeListURL, youtubeAPIKey)) + "&pageToken=" + nextPageToken!
            } else if self.youtubeList.nextPageToken == nil {
                searchURL = (String(format: apiConstants.youTubeListURL, youtubeAPIKey))
            }
        case .textSearch:
            if self.youtubeList.nextPageToken != nil && nextPageToken != "" {
                searchURL = (String(format: apiConstants.searchChannelURL, searchWord, youtubeAPIKey)) + "&pageToken=" + nextPageToken!
            } else if self.youtubeList.nextPageToken == nil {
                searchURL = (String(format: apiConstants.searchChannelURL, searchWord, youtubeAPIKey))
            }
        case .channelSearch:
            searchURL = (String(format: apiConstants.searchChannelIDURL, channelID, youtubeAPIKey))
        }
        self.loadYouTubeList(url: searchURL)
    }
    
    // 新着一覧
    private func loadYouTubeList(url: String) {
        
        let apiManager = APIManager()
        
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
