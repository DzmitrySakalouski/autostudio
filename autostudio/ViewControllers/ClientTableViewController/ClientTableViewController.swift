//
//  ClientTableViewController.swift
//  autostudio
//
//  Created by Dzmitry  Sakalouski  on 20.02.21.
//

import UIKit

class ClientTableViewController: UITableViewController {
    var viewModel: ClientsTableViewModelType?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        
        tableView.register(ClientTableViewCell.self, forCellReuseIdentifier: "clientCell")
        
        tableView.separatorStyle = .none
        tableView.bounces = false
        
        viewModel?.fetchClients() { [weak self] in // TODO remove int value
            if let errorMessage = self?.viewModel?.errorMessage {
                self?.tableView.headerView(forSection: 0)?.textLabel?.text = errorMessage
                return
            }

            self?.tableView.reloadData()
        }
    }
    
    func configureView() {
        view.backgroundColor = .white
    }
}

extension ClientTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let viewModel = viewModel else {
            return 0
        }
        
        print(viewModel.numberOfRows())
            
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
}
