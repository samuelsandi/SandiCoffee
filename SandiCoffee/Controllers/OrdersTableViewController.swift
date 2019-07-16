//
//  OrdersTableViewController.swift
//  SandiCoffee
//
//  Created by Samuel Lim on 15/07/19.
//  Copyright © 2019 Samuel Lim. All rights reserved.
//

import UIKit

class OrdersTableViewController: UITableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        populateOrders()
    }
    
    private func populateOrders(){
        guard let ordersURL = URL(string: "https://guarded-retreat-82533.herokuapp.com/orders") else {
            fatalError("URL was incorrect")
        }
        let resource = Resource<[Order]>(url:ordersURL)
        WebService().load(resource: resource) { result in
            switch result {
                case .success(let orders):
                    print(orders)
                case .failure(let error):
                    print(error)
            }
        }
    }
}
