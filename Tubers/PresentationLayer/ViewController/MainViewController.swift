//
//  MainViewController.swift
//  Tubers
//
//  Created by mmsc on 2018/11/23.
//  Copyright © 2018年 mmsc. All rights reserved.
//

import UIKit
import XLPagerTabStrip

/*
 - 画面表示やユーザのタッチイベントなどのイベントをPresenterに通知する
 - Presenterから受けたModelのデータやステータスによりViewの表示を切り替える
 */

class MainViewController: ButtonBarPagerTabStripViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // タブバー設定
        settingTabBar()
    }
    
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        
        //管理されるViewControllerを生成
        let firstVC = R.storyboard.main.first()
        let secondVC = R.storyboard.main.second()
        let thirdVC = R.storyboard.main.third()
        
        let childViewControllers:[UIViewController] = [firstVC!, secondVC!, thirdVC!]
        
        return childViewControllers
    }
    
    private func settingTabBar() {
        
        //バーの色
        settings.style.buttonBarBackgroundColor = UIColor(red: 73/255, green: 72/255, blue: 62/255, alpha: 1)
        //ボタンの色
        settings.style.buttonBarItemBackgroundColor = UIColor(red: 73/255, green: 72/255, blue: 62/255, alpha: 1)
        //セルの文字色
        settings.style.buttonBarItemTitleColor = UIColor.white
        //セレクトバーの色
        settings.style.selectedBarBackgroundColor = UIColor(red: 254/255, green: 0, blue: 124/255, alpha: 1)
    }
}

