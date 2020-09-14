//
//  DramasListViewModel.swift
//  dramas_sample
//
//  Created by Rock Chen on 2020/9/11.
//  Copyright © 2020 Rock Chen. All rights reserved.
//

import Foundation
import Reachability

final class DramasListViewModel {
    
    let status: Observable<ViewModelStatus> = Observable(.none)
    var searchResult = false
    var dataSource: [DramasModel] = []
    var filterDataSource: [DramasModel] = []
    var searchText: String = "" {
        didSet {
            search(searchText)
        }
    }
    
    fileprivate let saveSearchTextkey = "searchText"
    fileprivate let dramasTools = DramasTools()
    fileprivate var reachability: Reachability!
    
    deinit {
        reachability.stopNotifier()
        debugPrint(self)
    }
    
    init() {
        startReachability()
    }
    
    func load() {
        status.value = .start
        
        if reachability.connection == .unavailable {
            dataSource = getOffineData()
            searchText = getSearchText()
            status.value = .offline
        } else {
            interviewProvider.request(.dramas) { [unowned self] (result) in
                var err: Error?
                var model: DramasResponse?
                var list: [DramasModel] = []
                
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
                
                if let error = err {
                    self.dataSource = self.getOffineData()
                    self.searchText = self.getSearchText()
                    self.status.value = .error(error: error)
                } else {
                    if let data = model?.data {
                        data.forEach { (dramasData) in
                            let data = DramasModel(dramasData)
                            
                            list.append(data)
                        }
                        
                        self.dataSource = list
                        self.dramasTools.deleteAll()
                        self.dramasTools.insert(data)
                        self.searchText = self.getSearchText()
                    } else {
                        self.dataSource = self.getOffineData()
                        self.searchText = self.getSearchText()
                        self.status.value = .offline
                    }
                }
            }
        }
    }
}

extension DramasListViewModel {
    fileprivate func startReachability() {
        do {
            reachability = try Reachability()
            try reachability.startNotifier()
        } catch (let error) {
            debugPrint(error)
        }
    }
    
    fileprivate func getOffineData() -> [DramasModel] {
        let dramas = dramasTools.fetch(nil)
        var list: [DramasModel] = []
        
        dramas.forEach { (data) in
            let model = DramasModel(data)
            
            list.append(model)
        }
        
        return list
    }
    
    fileprivate func search(_ text: String) {
        filterDataSource = dataSource.filter { (data) -> Bool in
            return data.name.contains(text)
        }
        
        searchResult = text.count > 0
        syncSearchText(text)
        status.value = .completed
    }
    
    fileprivate func syncSearchText(_ text: String) {
        let userDefaults = UserDefaults.standard
        
        if text.count > 0 {
            userDefaults.set(text, forKey: saveSearchTextkey)
        } else {
            userDefaults.removeObject(forKey: saveSearchTextkey)
        }
        userDefaults.synchronize()
    }
    
    fileprivate func getSearchText() -> String {
        return UserDefaults.standard.string(forKey: saveSearchTextkey) ?? ""
    }
}
