//
//  YouTubeList.swift
//  Tubers
//
//  Created by mmsc on 2018/11/23.
//  Copyright © 2018年 mmsc. All rights reserved.
//

import Foundation
import Pods_Tubers

class YouTubeList: NSObject {
    
    func loadYouTubeList() {

//      XI7nbFXulYBIpL0ayR_gDh3eu1k/ewwRz0VbTYpp2EGbOkvZ5M_1mbo
        let apiManager = APIManager()
//        let x = "https://www.googleapis.com/youtube/v3/channels?part=contentDetails&key=AIzaSyBEa4NITxrcRcz3xmTthwDTX4FqIz9jJic&id=%E3%83%A9%E3%83%95%E3%82%A1%E3%82%A8%E3%83%AB"
        let x = "https://www.googleapis.com/youtube/v3/channels?part=contentDetails&key=AIzaSyBEa4NITxrcRcz3xmTthwDTX4FqIz9jJic&id=UCI8U2EcQDPwiQmQMBOtjzKA"
        apiManager.ConnectionAPI(url: x, success: {(result: NSArray) -> Void in
            
            
        }, failure: {(result: Error?) -> Void in
            
        })
    }
}
