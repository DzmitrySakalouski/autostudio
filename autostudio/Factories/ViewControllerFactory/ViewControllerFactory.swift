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
}
