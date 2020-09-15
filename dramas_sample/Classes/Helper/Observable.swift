//
//  Observable.swift
//  dramas_sample
//
//  Created by Rock Chen on 2020/9/13.
//  Copyright © 2020 Rock Chen. All rights reserved.
//

import Foundation
/// 輕量的觀察者模式
class Observable<T> {
    typealias Observer = (T) -> ()
    
    // 用於數據改變的執行
    private var observer: Observer?
    
    // 數據發生變更，則通過觀察者告知
    var value: T {
        didSet {
            observer?(value)
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    func observer(_ observer: Observer?) {
        self.observer = observer
        observer?(value)
    }
}
