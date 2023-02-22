//
//  TecentShareTool.swift
//  91Read
//
//  Created by 朱𣇈丹 on 2023/2/15.
//

import Foundation
import TencentOpenApiHub

class TencentShareTool: NSObject, ChindleShareProtocol, TencentSessionDelegate {
    
    static let shareInstance = TencentShareTool()
    
    var tencentOAuth: TencentOAuth?
    
    func tencentDidLogin() {
        //        if (_tencentOAuth.accessToken.length > 0) {
        //            // 获取用户信息
        //            [_tencentOAuth getUserInfo];
        //
        //            if(self.getAccessTokenAndOpenIDBlock && [_tencentOAuth getUserInfo]){
        //
        //                NSLog(@"accessToken=%@\nunionid=%@\nopenId=%@",_tencentOAuth.accessToken,_tencentOAuth.unionid,_tencentOAuth.openId);
        //                self.getAccessTokenAndOpenIDBlock(_tencentOAuth.accessToken,_tencentOAuth.unionid);
        //            }
        //
        //        } else {
        //            NSLog(@"登录不成功 没有获取accesstoken");
        //        }
        
//        [TencentOAuth setIsUserAgreedAuthorization:YES];
//
//        guard let tencentOAuth = tencentOAuth else {
//            return
//        }
//
//        if tencentOAuth.accessToken.count > 0 {
//
//            tencentOAuth.getUserInfo()
//
//            if
//        }
        
        
    }
    
    func tencentDidNotLogin(_ cancelled: Bool) {
        
    }
    
    func tencentDidNotNetWork() {
        
    }
    
    var appId: String?
    var universalLink: String?
    var redirectURI: String?
    
    func setupTencentConfig(appId: String?, universalLink: String?, redirectURI: String?) {
        
        self.appId = appId
        self.universalLink = universalLink
        self.redirectURI = redirectURI
        
        self.registerApp()
    }
    
    
    func registerApp() {
        
        guard let appId = appId else {
            print("qq appId不可用")
            return
        }
        
        guard let universalLink = universalLink else {
            print("qq universalLink不可用")
            return
        }
        
        guard let redirectURI = redirectURI else {
            print("qq redirectURI不可用")
            return
        }
        
        TencentOAuth.setIsUserAgreedAuthorization(true)
        
        tencentOAuth = TencentOAuth(appId: appId, andUniversalLink: universalLink, andDelegate: self)

        tencentOAuth!.redirectURI = redirectURI

        print("Tencent 初始化成功")

    }
    
    func printSdkVersion() {
        
        print("QQ SDK版本：\(String(describing: TencentOAuth.sdkVersion()))")
    }
    
    func isQQInstalled() -> Bool {
        
        return QQApiInterface.isQQInstalled()
    }
    
    func sendMessage(text: String, platform: SharePlatform) {
        let txtObj = QQApiTextObject(text: text)
        guard let req = SendMessageToQQReq(content: txtObj) else { return }
        
        //QQ文字分享 不支持QQ空间
        if platform == .QZone {
            
            let alerController = UIAlertController(title: "温馨提示", message: "QQ空间不支持分享文字", preferredStyle: .alert)
            let sureAction = UIAlertAction.init(title: "好的", style: .default)
            alerController.addAction(sureAction)
            ChindleShareHelp().getCurrentVc().present(alerController, animated: true)
            return
        }
        send(req: req, type: platform)
    }
    
    func sendImage(data: Data, title: String, description: String, platform: SharePlatform){
        
        let imgObj = QQApiImageObject(data: data, previewImageData: data, title: title, description: description)
        guard let req = SendMessageToQQReq(content: imgObj) else { return }
        
        send(req: req, type: platform)
        
    }
    
    func sendWebpageObject(webpageUrl: String, title: String, description: String,  thumbImage: String, platform: SharePlatform) {
        
        let newsObj = QQApiNewsObject(url: URL(string: webpageUrl),
                                      title: title,
                                      description: description,
                                      previewImageURL: URL(string: thumbImage), targetContentType: .news)
        
        guard let req = SendMessageToQQReq(content: newsObj) else { return }
        
        send(req: req, type: platform)

    }
    
    func send(req: SendMessageToQQReq, type: SharePlatform) {

        if type == .QZone {
            QQApiInterface.sendReq(toQZone: req)
            return
        }
        
        if type == .qqChat {
            QQApiInterface.send(req)
            return
        }
    }
    
    func handleOpen(url: URL) -> Bool {
        
        TencentOAuth.handleOpen(url)
    }
}
