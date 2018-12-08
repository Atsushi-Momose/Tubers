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
import RxCocoa
import RxSwift

class FirstViewController: UIViewController, IndicatorInfoProvider, UITableViewDelegate, UITableViewDataSource {
    
    let presenter = FirstViewPresenter()
    
    var youtubeList = [YouTubeList]()
    
    let disposeBag = DisposeBag()
    
    // ボタンタイトル
    var itemInfo: IndicatorInfo = "First"
    // インジケーター
    let progress = GradientCircularProgress()

    @IBOutlet weak var youtubListTableView: UITableView!
   
    override func viewDidLoad() {
        super.viewDidLoad()
       
        let progressView = progress.show(frame: self.view.frame, message: "Loading...", style: ProgressStyle())
        view.addSubview(progressView!)
        //progress.show()
        
        youtubListTableView.register (UINib(nibName: "YoutuberListTableViewCell", bundle: nil), forCellReuseIdentifier: "customCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Youtube一覧取得
        presenter.getYoutubeList()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        progress.dismiss()
    }
    
    //必須
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return itemInfo
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.youtubeList.count
    }
    
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell") as! YoutuberListTableViewCell
        return cell
    }
}
