//
//  ViewControllerFactory.swift
//  autostudio
//
//  Created by Dzmitry  Sakalouski  on 20.02.21.
//

import Swinject
import UIKit

class ViewControllerFactory: ClientViewControllerFactoryType {
    func makeEditClientViewController(client: Client, delegate: ClientTableViewModelDelegate) -> EditClientViewController {
        let editClientViewController = EditClientViewController()
        return editClientViewController
    }
    
    
    private var container: Container {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.container
    }
    
    func makeClientViewController() -> ClientTableViewController {
        let clientViewController = ClientTableViewController()
        return clientViewController
    }
    
    func makeCreateClientViewController() -> CreateClientViewController {
        let createClientViewController = CreateClientViewController()
        return createClientViewController
    }
    
    func makeClientDetailsViewController(delegate: ClientTableViewModelDelegate) -> ClientDetailsViewController {
        let clientDetailsViewController = ClientDetailsViewController()
        return clientDetailsViewController
    }
}
