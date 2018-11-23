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
        
        let apiManager = APIManager()

        apiManager.ConnectionAPI(url: TubersKeys().youtubeAPIKey, success: {(result: NSArray) -> Void in
  
            
        }, failure: {(result: Error?) -> Void in
            
        })
    }
}


