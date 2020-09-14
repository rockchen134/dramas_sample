//
//  Observable.swift
//  dramas_sample
//
//  Created by Rock Chen on 2020/9/13.
//  Copyright © 2020 Rock Chen. All rights reserved.
//

import Foundation

class Observable<T> {
    typealias Observer = (T) -> ()
    var observer: Observer?
    
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
