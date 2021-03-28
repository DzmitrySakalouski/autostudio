//
//  ClientDetailsViewController.swift
//  autostudio
//
//  Created by Dzmitry  Sakalouski  on 25.03.21.
//

import UIKit

class ClientDetailsViewController: UIViewController {
    var viewModel: ClientDetailsViewModelType!

    lazy var phoneLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.init(name: "Gill Sans", size: 18)
        return label
    }()
    
    lazy var carLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.init(name: "Gill Sans", size: 18)
        return label
    }()
    
    lazy var ordersLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 2
        label.font = UIFont.init(name: "Gill Sans", size: 18)
        return label
    }()
    
    lazy var feesLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.init(name: "Gill Sans", size: 18)
        return label
    }()
    
    lazy var deleteButton: UIBarButtonItem = {
        let deleteButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(handleDeleteClient))
        return deleteButtonItem
    }()
    
    lazy var editButton: UIBarButtonItem = {
        let editButtonItem = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(handleEditClientPress))
        return editButtonItem
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavBar()
        configureView()
        fillClientData()
    }
    
    func configureView() {
        view.backgroundColor = .white
        
        view.addSubview(phoneLabel)
        phoneLabel.anchor(top: view.topAnchor, left: view.leftAnchor, paddingTop: 20, paddingLeft: 10)
        
        view.addSubview(carLabel)
        carLabel.anchor(top: phoneLabel.bottomAnchor, left: view.leftAnchor, paddingTop: 10, paddingLeft: 10)

        view.addSubview(ordersLabel)
        ordersLabel.anchor(top: carLabel.bottomAnchor, left: view.leftAnchor, paddingTop: 10, paddingLeft: 10)

        view.addSubview(feesLabel)
        feesLabel.anchor(top: ordersLabel.bottomAnchor, left: view.leftAnchor, paddingTop: 10, paddingLeft: 10)
    }
    
    func fillClientData() {
        guard let vm = viewModel else {
            return
        }
        
        guard let client = vm.client else {
            return
        }
        navigationItem.title = client.fullName
        phoneLabel.text = client.phoneNumber
        carLabel.text = client.car
        print("Колличество заказов: \(client.offerCount!)")
        ordersLabel.text = "Колличество заказов: \(client.totalFeeAmount ?? "0")"
        if client.totalFeeAmount != nil {
            feesLabel.text = "Общая сумма всех заказов: \(String(describing: client.totalFeeAmount))"
        }
    }

    func configureNavBar() {
        navigationController?.navigationBar.backgroundColor = .white
        navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "Список клиетов", style: .plain, target: nil, action: nil)
        navigationItem.rightBarButtonItems = [deleteButton, editButton]
    }
    
    @objc func handleDeleteClient() {
        guard let vm = viewModel else { return }
        vm.deleteClient()
    }
    
    @objc func handleEditClientPress() {
        guard let vm = viewModel else { return }
        vm.editClient()
    }
}
