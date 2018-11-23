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
    
    //ここがボタンのタイトルに利用されます
    var itemInfo: IndicatorInfo = "First"

    // インジケーター
    let progress = GradientCircularProgress()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let progressView = progress.show(frame: self.view.frame, message: "Loading...", style: ProgressStyle())
        view.addSubview(progressView!)
    }
    
    //必須
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return itemInfo
    }
}
