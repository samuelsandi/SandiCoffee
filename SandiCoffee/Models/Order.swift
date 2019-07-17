//
//  Order.swift
//  SandiCoffee
//
//  Created by Samuel Lim on 16/07/19.
//  Copyright © 2019 Samuel Lim. All rights reserved.
//

import Foundation

enum CoffeeType: String, Codable, CaseIterable {
    case cappuccino
    case latte
    case espresso
    case americano
    case mochaccino
    case frappuccino
    case espressino
    case cortado
    case caibodas
}

enum CoffeeSize: String, Codable, CaseIterable {
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

extension Order {
    
    static var all: Resource<[Order]> = {
        guard let url = URL(string: "https://guarded-retreat-82533.herokuapp.com/orders") else {
            fatalError("The URL is incorrect")
        }
        return Resource<[Order]>(url:url)
    }()
    
    init?(_ vm: NewOrderViewModel){
        guard let name = vm.name,
        let email = vm.email,
        let selectedType = CoffeeType(rawValue: vm.selectedType!.lowercased()),
        let selectedSize = CoffeeSize(rawValue: vm.selectedSize!.lowercased()) else {
            return nil
        }
        
        self.name = name
        self.email = email
        self.type = selectedType
        self.size = selectedSize
    }
    
    static func create(_ vm: NewOrderViewModel) -> Resource<Order?> {
        let order = Order(vm)
        guard let url = URL(string: "https://guarded-retreat-82533.herokuapp.com/orders") else {
            fatalError("The URL is incorrect")
        }
        guard let data = try? JSONEncoder().encode(order) else {
            fatalError("Error encoding order")
        }
        var resource = Resource<Order?>(url: url)
        resource.httpMethod = HttpMethod.post
        resource.body = data
        return resource
    }
}
