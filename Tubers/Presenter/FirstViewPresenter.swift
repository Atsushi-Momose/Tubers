//
//  FirstViewPresenter.swift
//  Tubers
//
//  Created by mmsc on 2018/12/08.
//  Copyright © 2018年 mmsc. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

/*
 - Viewからイベントを受け取り、必要があればイベントに応じたUseCaseを実行する
 - UseCaseから受け取ったデータをViewへ渡す
 - Viewがどうなっているか知らない
 */

class FirstViewPresenter: NSObject {
    
    let youtubeUseCase = YoutubeUseCase()
    
    var youtubeList = YouTubeList()
    
    var nextPageToken = String()
    
    var searchWord = String()
    
    private let eventSubject = PublishSubject<Int>()
    var event: Observable<Int> { return eventSubject }
    
    // Youtube一覧
    func getYoutubeList() {
        let apiConstants = APIConstants()
        let youtubeAPIKey = String(TubersKeys().youtubeAPIKey())
        var url = String()
        
        if searchWord.count > 0 { // 検索
            if nextPageToken != "" {
                url = apiConstants.searchChannelURL + searchWord + "&key=" + youtubeAPIKey + "&pageToken=" + nextPageToken
                
            } else {
                url = apiConstants.searchChannelURL + searchWord + "&key=" + youtubeAPIKey
            }
        } else { // 新着一覧
            url = nextPageToken != "" ? apiConstants.youTubeListURL + youtubeAPIKey + "&pageToken=" + nextPageToken : apiConstants.youTubeListURL + youtubeAPIKey
        }
        youtubeUseCase.loadYouTubeList(url: url)
        getSubscribe()
    }
    
    // 検索
    func searchChannel(word: String) {
        searchWord = word
        nextPageToken = ""
        youtubeUseCase.isFirst = true
        
        // 検索実行
        getYoutubeList()
    }
    
    private func getSubscribe() {
        let _ = youtubeUseCase.event.subscribe (
            // 通常イベント発生時の処理
            onNext: { value in
                self.youtubeList = self.youtubeUseCase.youtubeList
                self.nextPageToken = self.youtubeUseCase.youtubeList.nextPageToken!
                self.eventSubject.onNext(1)
        },
            onError: { error in
                // エラー発生時の処理
        },
            onCompleted: {
                // 完了時の処理
        }
        )
        // 解放
        //disposable.dispose()
    }
}
