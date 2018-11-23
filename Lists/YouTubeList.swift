//
//  YouTubeList.swift
//  Tubers
//
//  Created by mmsc on 2018/11/23.
//  Copyright © 2018年 mmsc. All rights reserved.
//

import Foundation

class YouTubeList: NSObject {
    
    func loadYouTubeList() {
        
        let filePath = Bundle.main.path(forResource: "UrlList", ofType:"plist" )
        let plist = NSDictionary(contentsOfFile: filePath!)
        guard let url = plist!["youTubeListUrl"] as! String? else { return }
        
        let apiManager = APIManager()
        
        apiManager.ConnectionAPI(url: url, success: {(result: NSArray) -> Void in
  
        
            
            
        }, failure: {(result: Error?) -> Void in
            
        })
    }
}


