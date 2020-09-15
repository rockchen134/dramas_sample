//
//  DoubleExtension.swift
//  dramas_sample
//
//  Created by Rock Chen on 2020/9/11.
//  Copyright © 2020 Rock Chen. All rights reserved.
//

import Foundation

extension Double {
    /**
     轉換成帶有分數的字串

     - Parameter minimumFractionDigits: 最小分數位數.
     - Parameter maximumFractionDigits: 最大分數位數.
     */
    func decimal(_ minimumFractionDigits: Int = 1, maximumFractionDigits: Int = 1) -> String {
        let formatter = NumberFormatter()
        
        formatter.numberStyle = .none
        formatter.minimumFractionDigits = minimumFractionDigits
        formatter.maximumFractionDigits = maximumFractionDigits
        formatter.roundingMode = .floor
        
        return formatter.string(from: NSNumber(value: self)) ?? ""
    }
}
