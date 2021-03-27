//
//  ViewControllerFactory.swift
//  autostudio
//
//  Created by Dzmitry  Sakalouski  on 20.02.21.
//

import Swinject
import UIKit

class ViewControllerFactory: ClientViewControllerFactoryType {
    private var container: Container {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.container
    }
    
    func makeClientViewController() -> ClientTableViewController {
        let clientViewController = ClientTableViewController()
        let clientTableViewModel = container.resolve(ClientsTableViewModelType.self)
        clientViewController.viewModel = clientTableViewModel
        return clientViewController
    }
    
    func makeCreateClientViewController() -> CreateClientViewController {
        let createClientViewController = CreateClientViewController()
        let createClientViewmodel = container.resolve(CreateClientViewModelType.self)
        createClientViewController.viewModel = createClientViewmodel
        return createClientViewController
    }
    
    func makeClientDetailsViewController(delegate: ClientTableViewModelDelegate) -> ClientDetailsViewController {
        let clientDetailsViewController = ClientDetailsViewController()
        var clientDetailsViewModel = container.resolve(ClientDetailsViewModelType.self)
        clientDetailsViewModel?.delegate = delegate
        clientDetailsViewController.viewModel = clientDetailsViewModel
        return clientDetailsViewController
    }
}
