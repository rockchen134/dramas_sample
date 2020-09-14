//
//  InterviewService.swift
//  dramas_sample
//
//  Created by Rock Chen on 2020/9/11.
//  Copyright © 2020 Rock Chen. All rights reserved.
//

import Foundation
import Moya

let interviewProvider = MoyaProvider<InterviewService>(plugins: [NetworkLoggerPlugin()])

enum InterviewService {
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
        return "".data(using: .utf8)!
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
