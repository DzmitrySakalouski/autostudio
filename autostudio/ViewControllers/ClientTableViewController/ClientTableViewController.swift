//
//  ClientTableViewController.swift
//  autostudio
//
//  Created by Dzmitry  Sakalouski  on 20.02.21.
//

import UIKit
import RxSwift

class ClientTableViewController: UITableViewController {
    var viewModel: ClientsTableViewModelType? {
        didSet {
            viewModel?.getClients()
            print("didSet")
        }
    }
    
    let disposeBag = DisposeBag()
        
    var plusBarButton: UIBarButtonItem = {
        let btn = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(handleBarPlusPress))
        btn.tintColor = .black
        return btn
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = nil
        configureView()
        configureCallbacks()
        configureNavBar()
    }
    
    func configureNavBar() {
        navigationItem.rightBarButtonItem = plusBarButton
        navigationController?.navigationBar.isTranslucent = false
        navigationItem.largeTitleDisplayMode = .always
        navigationItem.title = "Список клиентов"
        navigationController?.navigationBar.backgroundColor = .white
        navigationController?.navigationBar.tintColor = .black
    }
    
    func configureView() {
        tableView.register(ClientTableViewCell.self, forCellReuseIdentifier: "clientCell")
        tableView.separatorStyle = .singleLine
        tableView.bounces = false

        plusBarButton.target = self
        
        view.backgroundColor = .white
    }
    
    @objc func handleBarPlusPress() {
        guard let vm = viewModel else { return }
        vm.didSaveClient?()
    }
    
    func configureCallbacks() {
        viewModel?.clients.asObservable().bind(to: tableView.rx.items(cellIdentifier: "clientCell", cellType: ClientTableViewCell.self)) { [weak self] (index, client, cell) in
            cell.viewModel = self?.viewModel?.cellViewModel(client: client)
        }.disposed(by: disposeBag)
        
        viewModel?.errorMsg.subscribe(onNext: { [weak self] value in
            guard let message = value else { return }
            self?.showEmptyMessage(message: message, viewController: self!)
        }).disposed(by: disposeBag)
    }
}

extension ClientTableViewController {
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let vm = viewModel else { return }
        vm.handleSelectClient(indexPath: indexPath)
    }
}
