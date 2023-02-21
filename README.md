# ChindleShareKit



## 背景

​	为了提高多项目开发效率，组件化是一个比较好的选择。也在考虑把什么功能写成组件，分享是一个在项目中用到比较多的功能。所以决定以分享功能为一个练手的点。把分享功能做成组件。

​	目前支持腾讯和微信分享。分享类型：文字、图片、链接。



## 优点

1.使用少量代码快速接入分享基础功能。（因为这个功能是公司内部用的，不适合公司外朋友使用）

2.不需要去手动下载腾讯SDK

3.减少接入分享引入的库



## 版本更新

​	V1.0.1:  支持腾讯和微信分享。分享类型：文字、图片、链接。（2023.02.21）



## 安装

​	目前只支持CocoaPods

​	Podfile

```ruby
pod 'ChindleShareKit' #分享Kit
pod 'TencentOpenApiHub' #腾讯分享
```

### 

## 使用



	##### 1.引入头文件

```swift
import ChindleShareKit
```



##### 2.**Associated Domains设置**

​	applinks:*.xxx.cn



##### 3.设置回调白名单

```html
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<array>
	<string>mqqapi</string>
	<string>mqqopensdkapiV2</string>
	<string>mqq</string>
	<string>mqqopensdkminiapp://</string>
	<string>mqqthirdappgroup://</string>
	<string>tencentapi.qzone.reqContent://</string>
	<string>tencentapi.qq.reqContent://</string>
	<string>mqzone://</string>
	<string>mqqopensdklaunchminiapp://</string>
	<string>mqqopensdkfriend://</string>
	<string>mqqopensdkavatar://</string>
	<string>mqqgamebindinggroup://</string>
	<string>mqqopensdkapiV2://</string>
	<string>mqqopensdknopasteboard://</string>
	<string>tim://</string>
	<string>mqqapi://</string>
	<string>mqq://</string>
	<string>weixinurlparamsapi</string>
	<string>weixinULAPI</string>
	<string>weixin</string>
	<string>wechat</string>
</array>
</plist>
```



##### 4.设置URL Types

```
Weixin - xxxxxx

QQ0xxxxxx

Tencentxxxx
```



##### 5.设置SDK常量

```swift
struct SDKConfig {
    
    static let wxAppId = "xxxxxx"
    
    static let wxAppSecret = "xxxxxx"

    static let wxAppLink = "xxxxxx"

    static let tencentAppId = "xxxxxx"

    static let tencentUniversalLink = "xxxxxx"

    static let tencentRedirectURI = "xxxxxxx"
}
```



##### 6.SDK初始化

```swift
//微信初始化
ChindleShareManager.shareInstance.setupWeChatConfig(appId: SDKConfig.wxAppId, appSecret: SDKConfig.wxAppSecret, appLink: SDKConfig.wxAppLink)
        
//QQ分享初始化
ChindleShareManager.shareInstance.setupTencentConfig(appId: SDKConfig.tencentAppId, universalLink: SDKConfig.tencentUniversalLink, redirectURI: SDKConfig.tencentRedirectURI)
```



##### 7.设置响应回调

```swift
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
```



##### 8.平台说明

```swift
//分享平台
public enum SharePlatform: Int {
    case wechat = 0, wxMoment = 1, qqChat, QZone
}
```



##### 9.文字分享

```swift
//文字分享
ChindleShareManager.shareInstance.sendMessage(text: "分享文字", platform: .qqChat)
```



##### 10.图片分享

```Swift
//图片分享
guard let imageData = UIImage(named: "vippay")?.jpegData(compressionQuality: 0.7) else { return }
ChindleShareManager.shareInstance.sendImage(data: imageData, title: "我是标题", description: "我是描述", platform: .wechat)
```



##### 11.链接分享

```swift
//链接分享
let imageData = UIImage(named: "vippay")
ChindleShareManager.shareInstance.sendWebpageObject(webpageUrl: "网络连接", title: "我是标题", description: "我是描述", thumbImage: "vippay", platform: .wechat)
```

