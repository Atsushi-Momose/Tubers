//
//  FirstViewController.swift
//  Tubers
//
//  Created by mmsc on 2018/11/23.
//  Copyright © 2018年 mmsc. All rights reserved.
//

import Foundation
import XLPagerTabStrip
import GradientCircularProgress

class FirstViewController: UIViewController, IndicatorInfoProvider {
    
    let presenter = FirstViewPresenter()
    
    // ボタンタイトル
    var itemInfo: IndicatorInfo = "First"
    // インジケーター
    let progress = GradientCircularProgress()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let progressView = progress.show(frame: self.view.frame, message: "Loading...", style: ProgressStyle())
        view.addSubview(progressView!)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Youtube一覧取得
        presenter.getYoutubeList()
    }
    
    //必須
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return itemInfo
    }
}
