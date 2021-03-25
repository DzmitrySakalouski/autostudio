//
//  ViewControllerFactory.swift
//  autostudio
//
//  Created by Dzmitry  Sakalouski  on 20.02.21.
//

import Foundation
import UIKit

class ViewControllerFactory: ClientViewControllerFactoryType {
    func makeClientViewController() -> ClientTableViewController {
        let clientViewController = ClientTableViewController()
        return clientViewController
    }
    
    func makeCreateClientViewController() -> CreateClientViewController {
        let createClientViewController = CreateClientViewController()
        return createClientViewController
    }
    
    func makeClientDetailsViewController() -> ClientDetailsViewController {
        let clientDetailsViewController = ClientDetailsViewController()
        return clientDetailsViewController
    }
}
