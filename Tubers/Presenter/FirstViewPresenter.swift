//
//  FirstViewPresenter.swift
//  Tubers
//
//  Created by mmsc on 2018/12/08.
//  Copyright © 2018年 mmsc. All rights reserved.
//

import Foundation

/*
 - Viewからイベントを受け取り、必要があればイベントに応じたUseCaseを実行する
 - UseCaseから受け取ったデータをViewへ渡す
 - Viewがどうなっているか知らない
*/
 
 class FirstViewPresenter: NSObject {
    
    let youtubeUseCase = YoutubeUseCase()
    
    // Youtube一覧
    func getYoutubeList() {
        youtubeUseCase.loadYouTubeList()
    }
}
