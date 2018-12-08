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
    
    private let eventSubject = PublishSubject<Int>()
    var event: Observable<Int> { return eventSubject }
    
    // Youtube一覧
    func getYoutubeList() {
        youtubeUseCase.loadYouTubeList()
        getSubscribe()
    }
    
    private func getSubscribe() {
        let _ = youtubeUseCase.event.subscribe (
            // 通常イベント発生時の処理
            onNext: { value in
                self.youtubeList = self.youtubeUseCase.youtubeList
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
