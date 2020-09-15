//
//  DramasListViewModel.swift
//  dramas_sample
//
//  Created by Rock Chen on 2020/9/11.
//  Copyright © 2020 Rock Chen. All rights reserved.
//

import Foundation
import Reachability

/// 戲劇列表 View Model
final class DramasListViewModel {
        
    let status: Observable<ViewModelStatus> = Observable(.none) // 資料取得的狀態
    var searchResult: Observable<Bool> = Observable(false) // 是否有搜尋到資料
    var offline: Observable<Bool> = Observable(false) // 網路狀態
    var dataSource: [DramasModel] = [] // 列表資料
    var filterDataSource: [DramasModel] = [] // 搜尋後的結果資料
    // 第一次進入畫面後提供給 View Controller的搜尋文字
    var searchText: String {
        get {
            return searchValue
        }
    }
    
    fileprivate var searchValue: String = "" // 主要是取得已儲存的搜尋文字
    fileprivate let saveSearchTextkey = "searchText" // 搜尋文字儲存在 UserDefault 的 Key
    fileprivate let dramasTools = DramasTools() // Core Data 操作元件
    fileprivate var reachability: Reachability! // 網路監聽元件
    
    deinit {
        reachability.stopNotifier()
        debugPrint(self)
    }
    
    init() {
        startReachability()
    }
    
    // 取得資料
    func load() {
        status.value = .start
        searchValue = getSearchText()
        
        // 沒有網路
        if reachability.connection == .unavailable {
            // 從 Core Data 取得上一次的 API資料
            dataSource = getOffineData()
            
            search(searchValue)
            
            status.value = .completed
            offline.value = true
        } else {
            interviewProvider.request(.dramas) { [unowned self] (result) in
                var err: Error?
                var model: DramasResponse?
                
                switch result {
                case let .success(response):
                    do {
                        let decoder = JSONDecoder()
                        
                        decoder.dateDecodingStrategy = .formatted(DateFormatter.iso8601Full)
                        
                        model = try response.filterSuccessfulStatusCodes().map(DramasResponse.self, using: decoder)
                    } catch (let error) {
                        debugPrint(error)
                        err = error
                    }
                case let .failure(error):
                    debugPrint(error)
                    err = error
                }
                
                // 發生錯誤，取得離線資料
                if let error = err {
                    self.dataSource = self.getOffineData()
                    
                    self.status.value = .error(error: error)
                    self.offline.value = true
                } else {
                    var list: [DramasModel] = []
                    
                    if let data = model?.data {
                        data.forEach { (dramasData) in
                            let data = DramasModel(dramasData)
                            
                            list.append(data)
                        }
                        
                        self.dataSource = list
                        self.dramasTools.deleteAll()
                        self.dramasTools.insert(data)
                        
                        self.status.value = .completed
                        self.offline.value = false
                    } else {
                        // 若取不到資料時，就取得離線資料
                        self.dataSource = self.getOffineData()
                        
                        self.status.value = .completed
                        self.offline.value = true
                    }
                }
                
                self.search(self.searchText)
            }
        }
    }
    
    /// 搜尋
    func search(_ text: String) {
        filterDataSource = dataSource.filter { (data) -> Bool in
            return data.name.contains(text)
        }
        
        syncSearchText(text)
        searchResult.value = text.count > 0
    }
    
    // 儲存搜尋文字到 User Default
    private func syncSearchText(_ text: String) {
        let userDefaults = UserDefaults.standard
        
        if text.count > 0 {
            userDefaults.set(text, forKey: saveSearchTextkey)
        } else {
            userDefaults.removeObject(forKey: saveSearchTextkey)
        }
        userDefaults.synchronize()
    }
    
    // 從 User Default 取得已儲存的搜尋文字
    private func getSearchText() -> String {
        return UserDefaults.standard.string(forKey: saveSearchTextkey) ?? ""
    }
}

extension DramasListViewModel {
    // 開啟監取網路狀態
    fileprivate func startReachability() {
        do {
            reachability = try Reachability()
            try reachability.startNotifier()
        } catch (let error) {
            debugPrint(error)
        }
    }
    
    // 取得離線資料
    fileprivate func getOffineData() -> [DramasModel] {
        let dramas = dramasTools.fetch(nil)
        var list: [DramasModel] = []
        
        dramas.forEach { (data) in
            let model = DramasModel(data)
            
            list.append(model)
        }
        
        return list
    }
}
