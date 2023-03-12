//
//  UserDefaultsStorage.swift
//  HW19
//
//  Created by Павел on 12.03.2023.
//

import Foundation

class  UserDefaultsStorage {
    static let shared = UserDefaultsStorage()
    var order: SortingViewModel {
        get {
           let order = UserDefaults.standard.integer(forKey: "SortingValue")
            return SortingViewModel(rawValue: order) ?? .asc
        }
        set {
            UserDefaults.standard.set(newValue.rawValue, forKey: "SortingValue")
        }
    }
    
    private init() {
    }
}
