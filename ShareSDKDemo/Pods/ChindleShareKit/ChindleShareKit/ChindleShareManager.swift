//
//  ChindleShareManager.swift
//  91Read
//
//  Created by 朱𣇈丹 on 2023/2/14.
//

import Foundation
import TencentOpenApiHub

@objcMembers
public class ChindleShareManager: NSObject, ChindleShareProtocol {
    
    public static let shareInstance = ChindleShareManager()

    var tencentAppId: String?

}

//注册
extension ChindleShareManager {
    
    //微信初始化
    public func setupWeChatConfig(appId: String?, appSecret: String?, appLink: String?, appState: String? = "123") {
        
        WeChatShareTool.shareInstance.setupConfig(appId: appId, appSecret: appSecret, appLink: appLink, appState: appState)
    }
    
    //qq初始化
    public func setupTencentConfig(appId: String?, universalLink: String?, redirectURI: String?) {
        
        tencentAppId = appId
        
        TencentShareTool.shareInstance.setupTencentConfig(appId: appId, universalLink: universalLink, redirectURI: redirectURI)
    }
}

//行为
extension ChindleShareManager {
    
    public func sendMessage(text: String, platform: SharePlatform) {
        
        if platform == .wxMoment || platform == .wechat {
            
            WeChatShareTool.shareInstance.sendMessage(text: text, platform: platform)
            
        }else{
            
            TencentShareTool.shareInstance.sendMessage(text: text, platform: platform)
        }
        
    }
    
    public func sendImage(data: Data, title: String, description: String, platform: SharePlatform) {
        
        if platform == .wxMoment || platform == .wechat {
            
            WeChatShareTool.shareInstance.sendImage(data: data, platform: platform)
            
        }else{
            
            TencentShareTool.shareInstance.sendImage(data: data, title: title, description: description, platform: platform)
        }
    }
    
    //微信链接分享图片链接要传本地的
    //QQ链接分享图片链接Url
    public func sendWebpageObject(webpageUrl: String, title: String, description: String, thumbImage: String, platform: SharePlatform) {
        
        if platform == .wxMoment || platform == .wechat {
            
            WeChatShareTool.shareInstance.sendWebpageObject(webpageUrl: webpageUrl, title: title, description: description, thumbImage: thumbImage, platform: platform)
            
        }else{
            
            TencentShareTool.shareInstance.sendWebpageObject(webpageUrl: webpageUrl, title: title, description: description, thumbImage: thumbImage, platform: platform)
        }
    }
}

//回调
extension ChindleShareManager {
    
    public func tencentHandleOpen(url: URL) -> Bool {
        
        return TencentShareTool.shareInstance.handleOpen(url: url)
    }
    
    public func wxHandleOpen(url: URL) -> Bool {
        
        return WeChatShareTool.shareInstance.handleWxOpenURL(url: url)
    }
        
    public func tencentHandleUniversalLink(url: URL) -> Bool {
        
        return TencentOAuth.handleUniversalLink(url)
    }
    
    public func wxHandleUniversalLink(userActivity: NSUserActivity) -> Bool {
        
        return WXApi.handleOpenUniversalLink(userActivity, delegate: WeChatShareTool.shareInstance)
    }
}
