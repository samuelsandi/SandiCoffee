//
//  OrdersTableViewController.swift
//  SandiCoffee
//
//  Created by Samuel Lim on 15/07/19.
//  Copyright © 2019 Samuel Lim. All rights reserved.
//

import UIKit

class OrdersTableViewController: UITableViewController {
    
    var orderListVM = OrderListViewModel()
    
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
                    self.orderListVM.orders = orders.map(OrderViewModel.init)
                    self.tableView.reloadData()
                case .failure(let error):
                    print(error)
            }
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.orderListVM.orders.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let vm = self.orderListVM.ordersAtIndex(at: indexPath.row)
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrderTableViewCell", for: indexPath)
        cell.textLabel?.text = vm.type
        cell.detailTextLabel?.text = vm.size
        return cell
    }
}
