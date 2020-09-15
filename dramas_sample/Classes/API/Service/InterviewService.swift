//
//  InterviewService.swift
//  dramas_sample
//
//  Created by Rock Chen on 2020/9/11.
//  Copyright © 2020 Rock Chen. All rights reserved.
//

import Foundation
import Moya

let interviewProvider: MoyaProvider<InterviewService> = ProviderFactory.create()

enum InterviewService {
    /// 取得戲劇列表
    case dramas
}

extension InterviewService: TargetType {
    var baseURL: URL {
        return URL(string: API.url)!
    }
    
    var path: String {
        switch self {
        case .dramas:
            return "interview/dramas-sample.json"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .dramas:
            return .get
        }
    }
    
    var sampleData: Data {
        switch self {
        case .dramas:
            guard let path = Bundle.main.path(forResource: "dramas-sample", ofType: "json"), let data = try? String(contentsOfFile: path).data(using: .utf8) else {
                return "".data(using: .utf8)!
            }
            return data
        }
    }
    
    var task: Task {
        switch self {
        case .dramas:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return ["Content-Type" : "application/json"]
    }
}
