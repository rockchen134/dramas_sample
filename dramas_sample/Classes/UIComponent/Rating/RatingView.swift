//
//  RatingView.swift
//  dramas_sample
//
//  Created by Rock Chen on 2020/9/11.
//  Copyright © 2020 Rock Chen. All rights reserved.
//

import UIKit
import LCNibBridge

class RatingView: UIView, LCNibBridge {

    @IBOutlet weak var ratingImageView: UIImageView!
    @IBOutlet weak var ratingLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.cornerRadius = frame.size.height / 2.0
    }
}
