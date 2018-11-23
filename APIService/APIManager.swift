//
//  APIManager.swift
//  Tubers
//
//  Created by mmsc on 2018/11/23.
//  Copyright © 2018年 mmsc. All rights reserved.
//

import Foundation
import Alamofire

class APIManager: NSObject {
    
    var youtubeNextPageToken: String?
    
    func ConnectionAPI(url: String, success: @escaping (_ result: NSArray) -> Void, failure: @escaping (Error?) -> Void) {
        
        Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: [:])
            
            .validate(statusCode: 200..<300)
            .responseJSON { response in
                switch response.result {
                case .success(_):
                    do {
                        guard let data = response.data else { return }
                        
                        let jsonResult = try JSONSerialization.jsonObject(with: data) as! NSMutableDictionary

                        self.youtubeNextPageToken = jsonResult["nextPageToken"] as! String?
                        let ary = jsonResult["items"] as! NSArray
                        //let youtubeList = YouTubeList(ary: ary)
                        success(ary)
                    }
                    catch {
                        failure(response.error)
                    }
                case .failure(_):
                    failure(response.error!)
                }
        }
    }
}
