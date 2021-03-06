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
    
    // 項番
    @IBOutlet weak var numberLabel: UILabel!
    
    // イメージ
    @IBOutlet weak var thumbnailImageView: UIImageView!
    
    // 名前
    @IBOutlet weak var channelTitleLabel: UILabel!
    
    // タイトル
    @IBOutlet weak var titleLabel: UILabel!
    
    // 日付け
    @IBOutlet weak var dateLabel: UILabel!
    
    func setUpCell(indexPath: Int, itemInfoList: YouTubeList.itemInfoList) {
        
        guard let snippet = itemInfoList.snippet  else { return }
        
        // 番号
        numberLabel.text = String(indexPath + 1)
        
        // Youtuber名
        channelTitleLabel.text = snippet.channelTitle
        
        // 動画タイトル
        titleLabel.text = snippet.title
        
        // 日付け
        var dateText = String()
       
        if let publishedAt = snippet.publishedAt {
           let strings = publishedAt.components(separatedBy: "T")
            dateText = strings.first!
        }
        
         dateLabel.text = dateText
        
        // イメージ
        guard let imageUrl = snippet.thumbnails?.default?.url else { return }
        thumbnailImageView.kf.setImage(with:  URL(string: imageUrl))
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
}
