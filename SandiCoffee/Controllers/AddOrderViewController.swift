//
//  AddOrderViewController.swift
//  SandiCoffee
//
//  Created by Samuel Lim on 15/07/19.
//  Copyright © 2019 Samuel Lim. All rights reserved.
//

import UIKit

protocol AddCoffeeOrderDelegate {
    func addCoffeeOrderViewControllerDidSave(order: Order, controller: UIViewController)
    func addCoffeeOrderViewControllerDidClose(controller: UIViewController)
}

class AddOrderViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var delegate: AddCoffeeOrderDelegate?
    
    private var newOrderVM = NewOrderViewModel()
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    private var coffeeSizeSegmentedControl: UISegmentedControl!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        self.coffeeSizeSegmentedControl = UISegmentedControl(items: self.newOrderVM.sizes)
        self.coffeeSizeSegmentedControl.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.coffeeSizeSegmentedControl)
        self.coffeeSizeSegmentedControl.topAnchor.constraint(equalTo: self.tableView.bottomAnchor, constant: 20).isActive = true
        self.coffeeSizeSegmentedControl.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.coffeeSizeSegmentedControl.tintColor = UIColor.brown
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .none
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.newOrderVM.types.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CoffeeTypeTableViewCell", for: indexPath)
        cell.textLabel?.text = self.newOrderVM.types[indexPath.row]
        return cell
    }
    
    @IBAction func saveOrderDidTapped() {
        let name = self.nameTextField.text
        let email = self.emailTextField.text
        let selectedSize = self.coffeeSizeSegmentedControl.titleForSegment(at: self.coffeeSizeSegmentedControl.selectedSegmentIndex)
        guard let indexPath = self.tableView.indexPathForSelectedRow else {
            fatalError("Coffee has not been selected!")
        }
        
        self.newOrderVM.name = name
        self.newOrderVM.email = email
        self.newOrderVM.selectedSize = selectedSize
        self.newOrderVM.selectedType = self.newOrderVM.types[indexPath.row]
        
        WebService().load(resource: Order.create(self.newOrderVM)){ result in
            switch result {
                case .success(let order):
                    print(order)
                    if let order = order, let delegate = self.delegate {
                        DispatchQueue.main.async {
                            delegate.addCoffeeOrderViewControllerDidSave(order: order, controller: self)
                        }
                    }
                case .failure(let error):
                    print(error)
            }
        }
    }
    
    @IBAction func closeButtonDidTapped() {
        if let delegate = self.delegate {
            DispatchQueue.main.async {
                delegate.addCoffeeOrderViewControllerDidClose(controller: self)
            }
        }
    }
}
