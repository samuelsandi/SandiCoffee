//
//  OrderViewModel.swift
//  SandiCoffee
//
//  Created by Samuel Lim on 16/07/19.
//  Copyright © 2019 Samuel Lim. All rights reserved.
//

import Foundation

struct OrderListViewModel {
    var orders: [OrderViewModel]
    init() {
        self.orders = [OrderViewModel]()
    }
    func ordersAtIndex (at index: Int) -> OrderViewModel {
        return self.orders[index]
    }
}

struct OrderViewModel {
    let order: Order
    var name: String {
        return self.order.name
    }
    var email: String {
        return self.order.email
    }
    var type: String {
        return self.order.type.rawValue.capitalized
    }
    var size: String {
        return self.order.size.rawValue.capitalized
    }
}
