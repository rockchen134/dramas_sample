//
//  NavigationController.swift
//  dramas_sample
//
//  Created by Rock Chen on 2020/9/13.
//  Copyright © 2020 Rock Chen. All rights reserved.
//

import UIKit

class NavigationController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationBar.tintColor = .white
        navigationBar.shadowImage = UIImage()
        
        delegate = self
    }
}

extension NavigationController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        let item = UIBarButtonItem(title: " ", style: .plain, target: nil, action: nil)
        viewController.navigationItem.backBarButtonItem = item
    }
}
