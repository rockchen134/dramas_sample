//
//  DramasDetailViewModel.swift
//  dramas_sample
//
//  Created by Rock Chen on 2020/9/14.
//  Copyright © 2020 Rock Chen. All rights reserved.
//

import Foundation
import Reachability

/// 戲劇資訊 View Model
final class DramasDetailViewModel {
    
    var offline: Observable<Bool> = Observable(false) // 網路狀態
    var dataSource: [DramasModel] = [] // 戲劇資訊資料
    
    fileprivate var reachability: Reachability! // 網路監聽元件
    
    deinit {
        reachability.stopNotifier()
        debugPrint(self)
    }
    
    init(_ dramas: DramasModel) {
        startReachability()
        dataSource.append(dramas)
    }
    
    func load() {
        if reachability.connection == .unavailable {
            offline.value = true
        } else {
            offline.value = false
        }
    }
}

extension DramasDetailViewModel {
    // 開啟監取網路狀態
    fileprivate func startReachability() {
        do {
            reachability = try Reachability()
            try reachability.startNotifier()
        } catch (let error) {
            debugPrint(error)
        }
    }
}
