//
//  ViewModelStatus.swift
//  dramas_sample
//
//  Created by Rock Chen on 2020/9/14.
//  Copyright © 2020 Rock Chen. All rights reserved.
//

import Foundation

/// View Model 取得資料的狀態
enum ViewModelStatus {
    case none
    case start // 開始取得資料
    case completed // 取得資料結束
    case error(error: Error) // 發生錯誤
}
