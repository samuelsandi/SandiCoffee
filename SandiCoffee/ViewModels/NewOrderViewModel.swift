//
//  NewOrderViewModel.swift
//  SandiCoffee
//
//  Created by OVO on 16/07/19.
//  Copyright © 2019 Samuel Lim. All rights reserved.
//

import Foundation

struct NewOrderViewModel {
    
    var name: String?
    var email: String?
    var types: [String] {
        return CoffeeType.allCases.map { $0.rawValue.capitalized }
    }
    var sizes: [String] {
        return CoffeeSize.allCases.map { $0.rawValue.capitalized }
    }
}
