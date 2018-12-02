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
    
    func ConnectionAPI(url: String, success: @escaping (_ result: Data) -> Void, failure: @escaping (Error?) -> Void) {
        
        Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: [:])
            
            .validate(statusCode: 200..<300)
            .responseJSON { response in
                switch response.result {
                case .success(_):
                    //do {
                        guard let data = response.data else { return }
                        
//                        let jsonResult = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSMutableDictionary
//
//                        let ary = jsonResult["items"] as! NSArray
                        
                        success(data)
//                    }
//                    catch {
//                        failure(response.error)
//                    }
                case .failure(_):
                    failure(response.error!)
                }
        }
    }
}
