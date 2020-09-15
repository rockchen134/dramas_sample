//
//  ViewModelStatus.swift
//  dramas_sample
//
//  Created by Rock Chen on 2020/9/14.
//  Copyright © 2020 Rock Chen. All rights reserved.
//

import Foundation

/// 提供 View Controller 在載入資料時 UI 的程現狀態
enum ViewModelStatus {
    case none
    case start // 開始取得資料
    case completed // 取得資料結束
    case error(error: Error) // 發生錯誤
}
