//
//  ViewModelStatus.swift
//  dramas_sample
//
//  Created by Rock Chen on 2020/9/14.
//  Copyright © 2020 Rock Chen. All rights reserved.
//

import Foundation

enum ViewModelStatus {
    case none
    case start
    case completed
    case offline
    case error(error: Error)
}
