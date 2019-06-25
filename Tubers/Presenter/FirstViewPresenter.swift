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
    var youtubeList = YouTubeList() // 新着/テキスト検索結果
    var searchWord = String()
    var channelID = String()
    var channelIDSearchResult = YouTubeList() // チャンネルID検索結果
    var selectedSearchType = searchType(rawValue: 0)
    
    private let eventSubject = PublishSubject<Int>()
    var event: Observable<Int> { return eventSubject }
    
    // Youtube一覧
    func getYoutubeList(searchType: searchType) {
        self.selectedSearchType = searchType
        youtubeUseCase.xxx(searchType: searchType, searchWord: self.searchWord, channelID: self.channelID)
        getSubscribe()
    }
    
    // 検索
    func searchChannel(word: String) {
        searchWord = word
        youtubeUseCase.isFirst = true
        getYoutubeList(searchType: .textSearch)
    }
    
    func initialize() { // メソッド名がイマイチ
        self.youtubeList = YouTubeList()
        self.searchWord = String()
        self.channelID = String()
        self.channelIDSearchResult = YouTubeList()
        self.selectedSearchType = searchType(rawValue: 0)
        
        self.youtubeUseCase.isFirst = true
        self.youtubeUseCase.youtubeList = YouTubeList()
        self.youtubeUseCase.channelIDSearchResult = YouTubeList()
    }
    
    private func getSubscribe() {
        let _ = youtubeUseCase.event.subscribe (
            // 通常イベント発生時の処理
            onNext: { value in
                switch self.selectedSearchType {
                case .channelSearch?:
                    self.channelIDSearchResult = self.youtubeUseCase.channelIDSearchResult
                case .newArrival?, .textSearch?:
                    self.youtubeList = self.youtubeUseCase.youtubeList // 新着/テキスト検索結果
                case .none:
                    assertionFailure()
                    return
                }
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
