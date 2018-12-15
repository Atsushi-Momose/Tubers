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

    // Youtube一覧
    var youtubeList = YouTubeList()
    
    // 初回取得
    var isFirst = true
    
    private let eventSubject = PublishSubject<Int>()
    var event: Observable<Int> { return eventSubject }
    
    func loadYouTubeList(nextPageToken: String = "") {
        
        let apiManager = APIManager()
        //        let x = "https://www.googleapis.com/youtube/v3/channels?part=contentDetails&key=AIzaSyBEa4NITxrcRcz3xmTthwDTX4FqIz9jJic&id=%E3%83%A9%E3%83%95%E3%82%A1%E3%82%A8%E3%83%AB"
        //        let x = "https://www.googleapis.com/youtube/v3/channels?part=contentDetails&key=AIzaSyBEa4NITxrcRcz3xmTthwDTX4FqIz9jJic&id=UCI8U2EcQDPwiQmQMBOtjzKA"
        
        let url = nextPageToken != "" ? TubersKeys().youtubeAPIKey + "&pageToken=" + nextPageToken : TubersKeys().youtubeAPIKey
        
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
