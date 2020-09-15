//
//  DramasResponse.swift
//  dramas_sample
//
//  Created by Rock Chen on 2020/9/11.
//  Copyright © 2020 Rock Chen. All rights reserved.
//

import Foundation

struct DramasResponse: Codable {
    struct DramasData: Codable {
        let drama_id: Int
        let name: String
        let total_views: Int
        let created_at: Date
        let thumb: URL
        let rating: Double
    }
    
    let data: [DramasData]
}

typealias DramasData = DramasResponse.DramasData
