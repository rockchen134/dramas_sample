//
//  DramasModel.swift
//  dramas_sample
//
//  Created by Rock Chen on 2020/9/13.
//  Copyright © 2020 Rock Chen. All rights reserved.
//

import Foundation

/// 戲劇的資料格式
struct DramasModel {
    let thumb: URL
    let name: String
    let createAt: String
    let rating: String
    let totalViews: String
    
    init(thumb: URL, name: String, createAt: String, rating: String, totalViews: String) {
        self.name = name
        self.rating = rating
        self.totalViews = totalViews
        self.createAt = createAt
        self.thumb = thumb
    }
    
    init(_ data: DramasData) {
        self.name = data.name
        self.rating = data.rating.decimal()
        self.totalViews = (Double(data.total_views) / 10000.0).decimal()
        self.createAt = data.created_at.toString("yyyy/MM/dd")
        self.thumb = data.thumb
    }
    
    init(_ entity: Dramas) {
        self.name = entity.name!
        self.rating = entity.rating.decimal()
        self.totalViews = (Double(entity.total_views) / 10000.0).decimal()
        self.createAt = entity.created_at!.toString("yyyy/MM/dd")
        self.thumb = URL(string: entity.thumb!)!
    }
}
