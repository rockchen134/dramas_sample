//
//  DateUtil.swift
//  dramas_sample
//
//  Created by Rock Chen on 2020/9/11.
//  Copyright © 2020 Rock Chen. All rights reserved.
//

import Foundation

extension Date {
    func toString(_ format: String = "yyyy/MM/dd HH:mm:ss ZZZ", timeZone: TimeZone = .current) -> String {
        let formatter = DateFormatter()
        
        formatter.timeZone = timeZone
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = format
        
        return formatter.string(from: self)
    }
}

extension String {
    func toDate(_ format: String = "yyyy-MM-dd'T'HH:mm:ss.SSSZ") -> Date? {
        let formatter = DateFormatter()
        
        formatter.dateFormat = format
        
        return formatter.date(from: self)
    }
}
