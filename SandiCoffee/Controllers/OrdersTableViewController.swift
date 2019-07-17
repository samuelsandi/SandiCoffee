//
//  OrdersTableViewController.swift
//  SandiCoffee
//
//  Created by Samuel Lim on 15/07/19.
//  Copyright © 2019 Samuel Lim. All rights reserved.
//

import UIKit

class OrdersTableViewController: UITableViewController, AddCoffeeOrderDelegate {
    
    var orderListVM = OrderListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        populateOrders()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let navigationController = segue.destination as? UINavigationController,
            let addCoffeeOrderVC = navigationController.viewControllers.first as? AddOrderViewController else {
            fatalError("Error performing segue!")
        }
        
        addCoffeeOrderVC.delegate = self
    }
    
    private func populateOrders(){
        
        
        WebService().load(resource: Order.all) { [weak self] result in
            switch result {
                case .success(let orders):
                    self?.orderListVM.orders = orders.map(OrderViewModel.init)
                    self?.tableView.reloadData()
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
    
    func addCoffeeOrderViewControllerDidClose(controller: UIViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    func addCoffeeOrderViewControllerDidSave(order: Order, controller: UIViewController) {
        controller.dismiss(animated: true, completion: nil)
        let orderVM = OrderViewModel(order: order)
        self.orderListVM.orders.append(orderVM)
        self.tableView.insertRows(at: [IndexPath.init(row: self.orderListVM.orders.count - 1, section: 0)], with: .automatic)
    }
}
