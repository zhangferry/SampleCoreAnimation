//
//  AppInfo.swift
//  ColoringWorld
//
//  Created by Beatman on 2017/6/2.
//  Copyright © 2017年 Meevii. All rights reserved.
//

import UIKit

class AppInfo {

    static let shared: AppInfo = AppInfo()
    
    static let screenWidth = UIScreen.main.bounds.width
    static let screenHeight = UIScreen.main.bounds.height

    /** height of statusbar */
    static var statusBarHeight:CGFloat{
        return UIApplication.shared.statusBarFrame.size.height
    }

}
