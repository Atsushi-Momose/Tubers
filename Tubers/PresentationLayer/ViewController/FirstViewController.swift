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
    
    var youtubeList = YouTubeList() // youtube一覧
    
    let disposeBag = DisposeBag()
    
    var isLoad =  false // 複数回APIを叩かない為のフラグ
    
    // ボタンタイトル
    var itemInfo: IndicatorInfo = "First"
    
    // インジケーター
    let progress = GradientCircularProgress()
    
    // インジケーター設定
    let progressStyle = ProgressStyle()

    @IBOutlet weak var youtubListTableView: UITableView!
   
    override func viewDidLoad() {
        super.viewDidLoad()
       
        progress.show(style: progressStyle)
        
        youtubListTableView.register (UINib(nibName: "YoutuberListTableViewCell", bundle: nil), forCellReuseIdentifier: "customCell")
        
        // Youtube一覧取得
        presenter.getYoutubeList()
        getSubscribe()
    }
    
    private func getSubscribe() {
        let _ = presenter.event.subscribe (
            // 通常イベント発生時の処理
            onNext: { value in
                self.youtubeList = self.presenter.youtubeList
                
                self.youtubListTableView.reloadData()
                self.isLoad = false
                self.progress.dismiss()
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
    
    // XLPagerTabStrip 必須
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return itemInfo
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let youtubeList = self.youtubeList.items else { return 0}
        return youtubeList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        tableView.estimatedRowHeight = 20 //セルの高さ
        return UITableViewAutomaticDimension //自動設定
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell") as! YoutuberListTableViewCell
        
        guard let items = self.youtubeList.items else { return cell }
        let itemInfo = items[indexPath.row]
        
        cell.setUpCell(indexPath: indexPath.row, itemInfoList: itemInfo)
        
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        // 一番下までスクロールした場合
        if youtubListTableView.contentOffset.y + youtubListTableView.frame.size.height > youtubListTableView.contentSize.height && youtubListTableView.isDragging {
           
            if !isLoad {
                progress.show(style: progressStyle)
                presenter.getYoutubeList()
                isLoad = true
            }
        }
    }
}
