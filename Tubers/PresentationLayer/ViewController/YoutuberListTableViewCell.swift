//
//  YoutuberListTableViewCell.swift
//  Tubers
//
//  Created by mmsc on 2018/12/09.
//  Copyright © 2018年 mmsc. All rights reserved.
//

import UIKit
import Kingfisher

class YoutuberListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var thumbnailImageView: UIImageView!
    
    // 名前
    @IBOutlet weak var channelTitleLabel: UILabel!
    
    // タイトル
    @IBOutlet weak var titleLabel: UILabel!
    
    // 日付け
    @IBOutlet weak var dateLabel: UILabel!
    
    func setUpCell(itemInfoList: YouTubeList.itemInfoList) {
        
        guard let snippet = itemInfoList.snippet  else { return }
        
        // Youtuber名
        channelTitleLabel.text = snippet.channelTitle
        
        // 動画タイトル
        titleLabel.text = snippet.title
        
        // イメージ
        guard let imageUrl = snippet.thumbnails?.default?.url else { return }
       // thumbnailImageView.kf.setImage(with: URL(string: imageUrl))
        
        thumbnailImageView.kf.setImage(with: URL(string: imageUrl), placeholder: nil, options: nil, progressBlock: { receivedSize, totalSize in
        }, completionHandler: { image, error, cacheType, imageURL in
        })
        
       // self.addSubview(thumbnailImageView)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
}
