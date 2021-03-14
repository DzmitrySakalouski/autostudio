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
    private let coordinatorFactory: CoordinatorFactoryType
         
    init(factory: ClientViewControllerFactoryType, navigator: NavigatorType, coordinatorFactory: CoordinatorFactoryType) {
        self.navigator = navigator
        self.factory = factory
        self.coordinatorFactory = coordinatorFactory
    }
    
    override func start() {
        showClientTable()
    }
    
    func showClientTable() {
        let clientTableVC = factory.makeClientViewController()
        clientTableVC.viewModel = ClientTableViewModel()
        clientTableVC.handleAddClientPress = runCreateClientFlow
        navigator.setRootModule(module: clientTableVC, hideNavBar: false)
    }
    
    func runCreateClientFlow() {
        let createClientCoordinator = coordinatorFactory.makeCreateClientCoordinator(navigator: navigator)
        addDependency(coordinator: createClientCoordinator)
        
        createClientCoordinator.finishFlow = { [weak self] in
            self?.navigator.dismissModule()
            self?.removeDependency(coordinator: createClientCoordinator)
        }
        
        createClientCoordinator.start()
    }
}
