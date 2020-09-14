//
//  UIViewController+Alert.swift
//  dramas_sample
//
//  Created by Rock Chen on 2020/9/14.
//  Copyright © 2020 Rock Chen. All rights reserved.
//

import UIKit

extension UIViewController {
    func Alert(_ title: String, message: String, comfirm: @escaping() -> Void) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: NSLocalizedString("confirm", comment: ""), style: .default) { (_) in
            comfirm()
        }
        alertController.addAction(confirmAction)
        present(alertController, animated: true)
    }
}
