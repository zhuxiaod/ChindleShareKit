//
//  WeChatShare.swift
//  91Read
//
//  Created by 朱𣇈丹 on 2023/2/14.
//

import Foundation

@objcMembers
public class WeChatShareTool: NSObject, ChindleShareProtocol, WXApiDelegate {
   
    public static let shareInstance = WeChatShareTool()
    
    var appId: String?
    
    var appSecret: String?

    var appLink: String?
    
    var appState: String?
    
    public func setupConfig(appId: String?, appSecret: String?, appLink: String?, appState: String? = "123") {
        
        self.appId = appId
        self.appSecret = appSecret
        self.appLink = appLink
        self.appState = appState
        
        self.registerApp()
    }

    func registerApp() {
        
        guard let wechatId = appId else {
            return
        }
        
        guard let wechatLink = appLink else {
            return
        }
        
        
        let isSuccess = WXApi.registerApp(wechatId, universalLink: wechatLink)
        
        print("WeChat 初始化\(isSuccess == true ? "成功" : "失败")")

    }
    
    public func printSdkVersion() {

        print(WXApi.getVersion())
    }

    //自检查
    public func checkSelf() {

        WXApi.startLog(by: .detail) { log in

            print(log)
        }

//        registerApp()

        WXApi.checkUniversalLinkReady { step, result in
            print("\(step) \(result.success) \(result.errorInfo) \(result.suggestion)")
        }
    }

    //处理URL
    public func handleWxOpenURL(url: URL) -> Bool {

        return WXApi.handleOpen(url, delegate: self)
    }

    //处理UserActivity
    public func handleOpenUniversalLink(userActivity: NSUserActivity) -> Bool {

        return WXApi.handleOpenUniversalLink(userActivity, delegate: self)
    }

    //是否安装
    public func isWxAppInstalled() -> Bool {
        return WXApi.isWXAppInstalled()
    }
    
}

public extension WeChatShareTool {
    
    //聊天界面  0 朋友圈  1
    
    //发送方法
    private func sendReq(message: WXMediaMessage, platform: SharePlatform) {

        let req = SendMessageToWXReq()
        req.bText = false
        req.message = message
        req.scene = platform == .wechat ? 0 : 1
        WXApi.send(req)

    }

    //文字分享
    func sendMessage(text: String, platform: SharePlatform) {

        let req = SendMessageToWXReq()
        req.bText = true
        req.text = text
        req.scene = platform == .wechat ? 0 : 1
        WXApi.send(req)

    }

    //图片分享
    func sendImage(data: Data, title: String = "", description: String = "", platform: SharePlatform) {

        let imgObj = WXImageObject()
        imgObj.imageData = data

        let mediaMsg = WXMediaMessage()
        mediaMsg.mediaObject = imgObj

        sendReq(message: mediaMsg, platform: platform)
    }

    //链接分享
    /*
     webpageUrl:链接
     title:标题
     description:描述
     thumbImage:显示图片
     */
    func sendWebpageObject(webpageUrl: String, title: String, description: String, thumbImage: String, platform: SharePlatform) {

        let webpageObject = WXWebpageObject()
        webpageObject.webpageUrl = webpageUrl

        let message = WXMediaMessage()
        message.title = title
        message.description = description

        let thumbImg: UIImage?

        if thumbImage.contains("http://") || thumbImage.contains("https://") {


            let thumbData = try? Data(contentsOf: URL(string: thumbImage)!)

            if let imgData = thumbData {
                thumbImg = UIImage(data: imgData)
            }else{
                thumbImg = nil
            }

        }else{

            thumbImg = UIImage(named: thumbImage)
        }

        message.setThumbImage(thumbImg ?? UIImage())
        message.mediaObject = webpageObject

        sendReq(message: message, platform: platform)

    }


}
