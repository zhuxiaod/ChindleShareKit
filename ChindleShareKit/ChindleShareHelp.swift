//
//  ChindleShareManager+Extension.swift
//  91Read
//
//  Created by 朱𣇈丹 on 2023/2/15.
//

import Foundation

class ChindleShareHelp {
    
     func getCurrentVc() -> UIViewController{
        let rootVc = UIApplication.shared.keyWindow?.rootViewController
        let currentVc = getCurrentVcFrom(rootVc!)
        return currentVc
    }
    
    func getCurrentVcFrom(_ rootVc:UIViewController) -> UIViewController{
        var currentVc:UIViewController
        var rootCtr = rootVc
        if(rootCtr.presentedViewController != nil) {
            rootCtr = rootVc.presentedViewController!
        }
        if rootVc.isKind(of:UITabBarController.classForCoder()) {
            currentVc = getCurrentVcFrom((rootVc as! UITabBarController).selectedViewController!)
        }else if rootVc.isKind(of:UINavigationController.classForCoder()){
            currentVc = getCurrentVcFrom((rootVc as! UINavigationController).visibleViewController!)
        }else{
            currentVc = rootCtr
        }
        return currentVc
    }
}

