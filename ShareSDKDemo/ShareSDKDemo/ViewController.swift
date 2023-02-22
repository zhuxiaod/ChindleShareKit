//
//  ViewController.swift
//  ShareSDKDemo
//
//  Created by 朱𣇈丹 on 2023/2/21.
//

import UIKit
import ChindleShareKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func log(_ sender: Any) {
        
        //文字分享
//        ChindleShareManager.shareInstance.sendMessage(text: "分享文字", platform: .wechat)

        //图片分享
        guard let imageData = UIImage(named: "vippay")?.jpegData(compressionQuality: 0.7) else { return }
        ChindleShareManager.shareInstance.sendImage(data: imageData, title: "我是标题", description: "我是描述", platform: .wechat)

        
    }
    
}

