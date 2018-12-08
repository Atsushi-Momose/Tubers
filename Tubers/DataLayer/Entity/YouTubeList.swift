//
//  YouTubeList.swift
//  Tubers
//
//  Created by mmsc on 2018/12/01.
//  Copyright © 2018年 mmsc. All rights reserved.
//

import Foundation

struct YouTubeList: Codable {
    
    var pageInfo: pInfo?
    var etag: String?
    var kind: String?
    var items: [itemInfoList]?
    var nextPageToken: String?
    var regionCode: String?
    
    struct pInfo: Codable {
        var resultsPerPage: NSInteger?
        var totalResults: NSInteger?
    }
    
    struct itemInfoList: Codable {
        var etag: String?
        var kind: String?
        var id: idItems?
        var snippet: snipetItem?
    }
    
    struct idItems: Codable {
        var kind: String?
        var videoId: String?
    }
    
    struct snipetItem: Codable {
        var thumbnails: thumbnailList?
        var channelId: String?
        var title: String?
        var publishedAt: String?
        var description: String?
        var liveBroadcastContent: String?
        var channelTitle: String?
    }
    
    struct thumbnailList: Codable {
        var `default`: defaultItems?
        var high: defaultItems?
        var medium: defaultItems?
    }
    
    struct defaultItems: Codable {
        var url: String?
        var width: NSInteger?
        var height: NSInteger?
    }
}
