//
//  FirstViewController.swift
//  Tubers
//
//  Created by mmsc on 2018/11/23.
//  Copyright © 2018年 mmsc. All rights reserved.
//

import Foundation
import XLPagerTabStrip
import RxCocoa
import RxSwift

class FirstViewController: UIViewController, IndicatorInfoProvider, UITableViewDelegate, UITableViewDataSource {
    
    let presenter = FirstViewPresenter()
    
    let youtubeChannelViewController = YoutubeChannelViewController()
    
    var youtubeList = YouTubeList() // youtube一覧
    
    let disposeBag = DisposeBag()
    
    var isLoad = false // 複数回APIを叩かない為のフラグ
    
    // ボタンタイトル
    var itemInfo: IndicatorInfo = "First"
    
    @IBOutlet weak var searchTextField: UITextField!
   
    @IBOutlet weak var searchButton: UIButton!
    
    @IBOutlet weak var youtubListTableView: UITableView!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        searchTextField.placeholder = "チャンネル名を入力"
        
        youtubListTableView.register (UINib(nibName: "YoutuberListTableViewCell", bundle: nil), forCellReuseIdentifier: "customCell")
        
        // Youtube一覧取得
        presenter.getYoutubeList(searchType: .newArrival)
        getSubscribe()
    }
    
    private func getSubscribe() {
        let _ = presenter.event.subscribe (
            // 通常イベント発生時の処理
            onNext: { value in
                switch self.presenter.selectedSearchType {
                case .channelSearch?:
                    print("channelSearch")
                    //self.showYoutubeModalViewController(channelInfo: self.presenter.channelIDSearchResult)
                case .newArrival?, .textSearch?:
                    self.youtubeList = self.presenter.youtubeList
                    self.youtubListTableView.reloadData()
                    self.isLoad = false
                case .none:
                    assertionFailure()
                }
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
        return UITableView.automaticDimension //自動設定
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell") as! YoutuberListTableViewCell
        
        guard let items = self.youtubeList.items else { return cell }
        let itemInfo = items[indexPath.row]
        
        cell.setUpCell(indexPath: indexPath.row, itemInfoList: itemInfo)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let videoID = youtubeList.items?[indexPath.row].id?.videoId else { return }
        
        self.showYoutubeModalViewController(channelInfo: videoID)
//        guard let channelID = youtubeList.items?[indexPath.row].snippet?.channelId else { return }
//        presenter.channelID = channelID
//        presenter.getYoutubeList(searchType: .channelSearch)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        // 一番下までスクロールした場合
        if youtubListTableView.contentOffset.y + youtubListTableView.frame.size.height > youtubListTableView.contentSize.height && youtubListTableView.isDragging {
           
            if !isLoad {
                presenter.getYoutubeList(searchType: .textSearch)
                isLoad = true
            }
        }
    }
    
    func showYoutubeModalViewController(channelInfo: String) {
        guard let vc = R.storyboard.youtubeChannelViewController().instantiateViewController(withIdentifier: "channel") as? YoutubeChannelViewController
            else {
            assertionFailure()
            return
        }
        
        vc.videoID = channelInfo
        
        self.present(vc, animated: true, completion: nil)
    }
    
    func trim(string: String) -> String {
        return string.trimmingCharacters(in: .whitespaces)
    }
    
    func urlEncode(string: String) -> String {
        return string.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!
    }
    
    @IBAction func searchButtonAction(_ sender: UIButton) {

        // 余分なスペースは除く
        let text = trim(string: searchTextField.text!)

        if text.count == 0 {
            presenter.initialize()
            presenter.getYoutubeList(searchType: .newArrival)
            getSubscribe()
            return
        }
        
        presenter.searchChannel(word: urlEncode(string: text))
    }
}

extension FirstViewController: UITextFieldDelegate {
    
}
