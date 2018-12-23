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
        youtubeUseCase.loadYouTubeList(nextPageToken: self.nextPageToken)
        getSubscribe(nextPageToken: self.nextPageToken)
    }
    
    // 検索 初回
    func setSearchChannelFlag(word: String) {
        searchWord = word
        nextPageToken = ""
        youtubeUseCase.isFirst = true
        // 検索実行
        searchChannel()
    }
    
    // 検索
    func searchChannel() {
        youtubeUseCase.searchChannel(word: searchWord, nextPageToken: self.nextPageToken)
        getSubscribe(nextPageToken: self.nextPageToken)
    }
    
    private func getSubscribe(nextPageToken : String = "") {
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
