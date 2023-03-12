//
//  SortingViewModel.swift
//  HW19
//
//  Created by Павел on 12.03.2023.
//

import Foundation

enum SortingViewModel: Int {
    case asc = 0 // по возрастанию
    case desc = 1 // по убыванию
    
    func toggled() -> SortingViewModel {
        switch self {
        case .asc:
            return .desc
        case .desc:
            return .asc
        }
    }
}
