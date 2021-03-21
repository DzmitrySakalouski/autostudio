//
//  ClientTableViewController.swift
//  autostudio
//
//  Created by Dzmitry  Sakalouski  on 20.02.21.
//

import UIKit
import RxSwift

class ClientTableViewController: UITableViewController {
    var viewModel: ClientsTableViewModelType?
    var handleAddClientPress: (() -> ())?
    
    let disposeBag = DisposeBag()
    
    var plusBarButton: UIBarButtonItem = {
        let btn = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(handleBarPlusPress))
        btn.tintColor = .white
        return btn
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = nil
        
        configureView()
        configureCallbacks()
    }
    
    func configureView() {
        tableView.register(ClientTableViewCell.self, forCellReuseIdentifier: "clientCell")
        tableView.separatorStyle = .singleLine
        tableView.bounces = false

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
    
    func configureCallbacks() {
        viewModel?.clients?.bind(to: tableView.rx.items(cellIdentifier: "clientCell", cellType: ClientTableViewCell.self)) { [weak self] (index, client, cell) in
            print(client)
            cell.viewModel = self?.viewModel?.cellViewModel(client: client)
        }.disposed(by: disposeBag)
        
        print("Configure")
        
        viewModel?.errorMsg.subscribe(onNext: { [weak self] value in
            print("errormsg", value)
            guard let message = value else { return }
            self?.showEmptyMessage(message: message, viewController: self!)
        }).disposed(by: disposeBag)
    }
}

extension ClientTableViewController {
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
