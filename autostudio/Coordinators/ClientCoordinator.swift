//
//  ClientCoordinator.swift
//  autostudio
//
//  Created by Dzmitry  Sakalouski  on 20.02.21.
//

import Foundation

class ClientCoordinator: BaseCoordinator {
//    var finishFlow: (() -> Void)?
    
    private let navigator: NavigatorType
    private let factory: ClientViewControllerFactoryType
         
    init(factory: ClientViewControllerFactoryType, navigator: NavigatorType) {
        self.navigator = navigator
        self.factory = factory
    }
    
    override func start() {
        showClientTable()
    }
    
    func showClientTable() {
        let clientTableVC = factory.makeClientViewController()
        navigator.setRootModule(module: clientTableVC, hideNavBar: false)
    }
}
