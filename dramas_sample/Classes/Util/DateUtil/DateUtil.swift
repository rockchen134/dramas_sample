//
//  DateUtil.swift
//  dramas_sample
//
//  Created by Rock Chen on 2020/9/11.
//  Copyright © 2020 Rock Chen. All rights reserved.
//

import Foundation

extension Date {
    /**
     日期轉成字串格式，預設格式為 yyyy/MM/dd HH:mm:ss ZZZ
     
     - Parameter format: 預轉出換的日期格式，預設為　yyyy/MM/dd HH:mm:ss ZZZ
     - Parameter timeZone: 時區，預設為系統的時區
     */
    func toString(_ format: String = "yyyy/MM/dd HH:mm:ss ZZZ", timeZone: TimeZone = .current) -> String {
        let formatter = DateFormatter()
        
        formatter.timeZone = timeZone
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = format
        
        return formatter.string(from: self)
    }
}
