//
//  ProviderFactory.swift
//  dramas_sample
//
//  Created by Rock Chen on 2020/9/15.
//  Copyright © 2020 Rock Chen. All rights reserved.
//

import Moya

/// 連立呼叫API的實體工廠模式
struct ProviderFactory {
    static func create<Target: TargetType>() -> MoyaProvider<Target> {
        let plugins = [NetworkLoggerPlugin()]
        
        let isUnitTesting = ProcessInfo.processInfo.environment["isRunUnitTest"] != nil
        
        // 如果是 unit test 則呼叫 JSON 檔案
        if isUnitTesting {
            return MoyaProvider<Target>(stubClosure: MoyaProvider.immediatelyStub, plugins: plugins)
        } else {
            return MoyaProvider<Target>(plugins: plugins)
        }
    }
}
