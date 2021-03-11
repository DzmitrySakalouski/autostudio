//
//  ClientTableViewController.swift
//  autostudio
//
//  Created by Dzmitry  Sakalouski  on 20.02.21.
//

import UIKit

class ClientTableViewController: UITableViewController {
    var viewModel: ClientsTableViewModelType?
    var handleAddClientPress: (() -> ())?
    
    var plusBarButton: UIBarButtonItem = {
        let btn = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(handleBarPlusPress))
        btn.tintColor = .white
        return btn
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        
        tableView.register(ClientTableViewCell.self, forCellReuseIdentifier: "clientCell")
        
        tableView.separatorStyle = .none
        tableView.bounces = false
        
        viewModel?.fetchClients() { [weak self] in // TODO remove int value
            if let errorMessage = self?.viewModel?.errorMessage {
                self?.showEmptyMessage(message: errorMessage, viewController: self!)
                return
            }

            self?.tableView.reloadData()
        }
    }
    
    func configureView() {
        plusBarButton.target = self
        
        view.backgroundColor = .white
        navigationController!.navigationBar.isTranslucent = false
        navigationController!.navigationBar.barTintColor = .gray
        navigationItem.rightBarButtonItem = plusBarButton
    }
    
    @objc func handleBarPlusPress() {
        if handleAddClientPress != nil {
            handleAddClientPress!()
        }
    }
}

extension ClientTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let viewModel = viewModel else {
            return 0
        }
                    
        return viewModel.numberOfRows()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "clientCell", for: indexPath) as? ClientTableViewCell
            if let tableCell = cell {
                guard let viewModel = viewModel else {
                    return UITableViewCell()
                }
                
                let cellVM = viewModel.cellViewModel(forIndexPath: indexPath)
                tableCell.viewModel = cellVM

                return tableCell
            }
            
            return UITableViewCell()
        }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        guard let vm = viewModel else { return 0 }
        if vm.numberOfRows() > 0 {
            return 1
        } else {
            self.showEmptyMessage(message: "No clients to display", viewController: self)
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat { // MOVE
        return 100
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
