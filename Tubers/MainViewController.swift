//
//  MainViewController.swift
//  Tubers
//
//  Created by mmsc on 2018/11/23.
//  Copyright © 2018年 mmsc. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class MainViewController: ButtonBarPagerTabStripViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        
        //管理されるViewControllerを生成
        let firstVC = R.storyboard.main.first()
        let secondVC = R.storyboard.main.second()
        let thirdVC = R.storyboard.main.third()
        
        let childViewControllers:[UIViewController] = [firstVC!, secondVC!, thirdVC!]
        
        return childViewControllers
    }
}

