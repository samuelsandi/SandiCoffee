//
//  Order.swift
//  SandiCoffee
//
//  Created by Samuel Lim on 16/07/19.
//  Copyright © 2019 Samuel Lim. All rights reserved.
//

import Foundation

enum CoffeeType: String, Codable {
    case cappuccino
    case latte
    case espresso
    case americano
    case mochaccino
    case frappuccino
}

enum CoffeeSize: String, Codable {
    case small
    case medium
    case large
}

struct Order: Codable {
    let name: String
    let email: String
    let type: CoffeeType
    let size: CoffeeSize
}
