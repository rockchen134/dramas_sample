//
//  UINavigationControllExtension.swift
//  dramas_sample
//
//  Created by Rock Chen on 2020/9/13.
//  Copyright © 2020 Rock Chen. All rights reserved.
//

import UIKit

extension UINavigationBar {
    func transparent() {
        setBackgroundImage(UIImage(), for: .default)
    }
    
    func untransparent() {
        setBackgroundImage(nil, for: .default)
    }
}
