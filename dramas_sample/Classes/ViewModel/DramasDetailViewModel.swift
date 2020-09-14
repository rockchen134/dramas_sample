//
//  DramasDetailViewModel.swift
//  dramas_sample
//
//  Created by Rock Chen on 2020/9/14.
//  Copyright © 2020 Rock Chen. All rights reserved.
//

import Foundation
import Reachability

final class DramasDetailViewModel {
    
    let status: Observable<ViewModelStatus> = Observable(.none)
    var dataSource: [DramasModel] = []
    
    fileprivate var reachability: Reachability!
    
    deinit {
        reachability.stopNotifier()
        debugPrint(self)
    }
    
    init(_ dramas: DramasModel) {
        startReachability()
        dataSource.append(dramas)
    }
    
    func load() {
        status.value = .start
        if reachability.connection == .unavailable {
            status.value = .offline
        } else {
            status.value = .completed
        }
    }
}

extension DramasDetailViewModel {
    fileprivate func startReachability() {
        do {
            reachability = try Reachability()
            try reachability.startNotifier()
        } catch (let error) {
            debugPrint(error)
        }
    }
}
