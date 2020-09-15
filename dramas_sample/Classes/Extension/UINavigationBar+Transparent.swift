//
//  UINavigationControllExtension.swift
//  dramas_sample
//
//  Created by Rock Chen on 2020/9/13.
//  Copyright © 2020 Rock Chen. All rights reserved.
//

import UIKit

extension UINavigationBar {
    /// 設定 Navigation Bar 為透明
    func transparent() {
        setBackgroundImage(UIImage(), for: .default)
    }
    
    /// 設定 Navigation Bar 為不透明
    func untransparent() {
        setBackgroundImage(nil, for: .default)
    }
}
