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
    
    private let eventSubject = PublishSubject<Int>()
    var event: Observable<Int> { return eventSubject }
    
    func loadYouTubeList() {
        
        let apiManager = APIManager()
        //        let x = "https://www.googleapis.com/youtube/v3/channels?part=contentDetails&key=AIzaSyBEa4NITxrcRcz3xmTthwDTX4FqIz9jJic&id=%E3%83%A9%E3%83%95%E3%82%A1%E3%82%A8%E3%83%AB"
        //        let x = "https://www.googleapis.com/youtube/v3/channels?part=contentDetails&key=AIzaSyBEa4NITxrcRcz3xmTthwDTX4FqIz9jJic&id=UCI8U2EcQDPwiQmQMBOtjzKA"
        
        let x = TubersKeys().youtubeAPIKey
        
        apiManager.ConnectionAPI(url: x, success: {(result: Data) -> Void in
            
            let decoder: JSONDecoder = JSONDecoder()
            do {
                self.youtubeList = try decoder.decode(YouTubeList.self, from: result)
                self.eventSubject.onNext(1)
            } catch {
                print("json convert failed in JSONDecoder", error.localizedDescription)
            }
        }, failure: {(result: Error?) -> Void in
            
        })
    }
}
