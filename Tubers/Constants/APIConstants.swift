//
//  APIConstants.swift
//  Tubers
//
//  Created by mmsc on 2018/12/23.
//  Copyright © 2018年 mmsc. All rights reserved.
//

import Foundation

class APIConstants: NSObject {
    
    // youtube一覧
    let youTubeListURL = "https://www.googleapis.com/youtube/v3/search?part=snippet&maxResults=40&order=date&type=video&key="
    
    // channel検索
    let searchChannelURL = "https://www.googleapis.com/youtube/v3/search?type=video&part=snippet&maxResults=40&order=date&q="
}
