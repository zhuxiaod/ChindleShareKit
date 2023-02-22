//
//  AppDelegate.swift
//  ShareSDKDemo
//
//  Created by 朱𣇈丹 on 2023/2/21.
//

import UIKit
import ChindleShareKit


struct SDKConfig {
    
    static let wxAppId = "xxxxx"
    
    static let wxAppSecret = "xxxxxxx"

    static let wxAppLink = "https://xxxxxxxxxxx"

    static let tencentAppId = "xxxxxx"

    static let tencentUniversalLink = "https://xxxxxxxxx"

    static let tencentRedirectURI = tencentUniversalLink
}


@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        
        //微信初始化
        ChindleShareManager.shareInstance.setupWeChatConfig(appId: SDKConfig.wxAppId, appSecret: SDKConfig.wxAppSecret, appLink: SDKConfig.wxAppLink)
        
        //QQ分享初始化
        ChindleShareManager.shareInstance.setupTencentConfig(appId: SDKConfig.tencentAppId, universalLink: SDKConfig.tencentUniversalLink, redirectURI: SDKConfig.tencentRedirectURI)
        
        
        
        
        
        
        
        return true
    }

    func application(_ application: UIApplication, handleOpen url: URL) -> Bool {

        print("url:\(url)")

        if url.absoluteString.contains(SDKConfig.tencentAppId) {

            return ChindleShareManager.shareInstance.wxHandleOpen(url: url)

        }else if url.absoluteString.contains(SDKConfig.wxAppId){

            return ChindleShareManager.shareInstance.tencentHandleOpen(url: url)
        }

        return true
    }

    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {

        if url.absoluteString.contains(SDKConfig.tencentAppId) {

            return ChindleShareManager.shareInstance.wxHandleOpen(url: url)

        }else if url.absoluteString.contains(SDKConfig.wxAppId){

            return ChindleShareManager.shareInstance.tencentHandleOpen(url: url)
        }

        return true
    }

    func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {

        let url = userActivity.webpageURL

        if ((url?.absoluteString.contains(SDKConfig.tencentAppId)) != nil) {

            return ChindleShareManager.shareInstance.tencentHandleUniversalLink(url: url ?? URL(string: "")!)

        }else if ((url?.absoluteString.contains(SDKConfig.wxAppId)) != nil){

            return ChindleShareManager.shareInstance.wxHandleUniversalLink(userActivity: userActivity)

        }

        return true

    }
    
}

