//
//  ChindleShareProtocol.swift
//  91Read
//
//  Created by 朱𣇈丹 on 2023/2/14.
//

import Foundation

public enum SharePlatform: Int {
    case wechat = 0, wxMoment = 1, qqChat, QZone
}

protocol ChindleShareProtocol {
    
    func sendMessage(text: String , platform: SharePlatform)
    
    func sendImage(data: Data,
                   title: String,
                   description: String,
                   platform: SharePlatform)
    
    func sendWebpageObject(webpageUrl: String,
                           title: String,
                           description: String,
                           thumbImage: String,
                           platform: SharePlatform)

}
