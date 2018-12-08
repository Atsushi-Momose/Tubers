//
//  YoutuberListTableViewCell.swift
//  Tubers
//
//  Created by mmsc on 2018/12/09.
//  Copyright © 2018年 mmsc. All rights reserved.
//

import UIKit

class YoutuberListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var thumbnailImageView: UIImageView!
    
    // 名前
    @IBOutlet weak var channelTitleLabel: UILabel!
    
    // タイトル
    @IBOutlet weak var titleLabel: UILabel!
    
    // 日付け
    @IBOutlet weak var dateLabel: UILabel!
    
    func setUp(itemInfoList: Array<Any>) {
        
        //guard let items = youtubeList.items![index] else { return }
        //thumbnailImageView.image = youtubeList[0]
        
        //titleLabel.text = youtubeList.
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
