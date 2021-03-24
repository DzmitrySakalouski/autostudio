//
//  ClientCoordinator.swift
//  autostudio
//
//  Created by Dzmitry  Sakalouski  on 20.02.21.
//

import Foundation
import Swinject

class ClientCoordinator: BaseCoordinator {
    private let navigator: NavigatorType
    private let factory: ClientViewControllerFactoryType
    private let coordinatorFactory: CoordinatorFactoryType
    
    var didFinishSaveClient: (() -> ())?
    
    private var container: Container {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.container
    }
         
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
        let clientTableVM = container.resolve(ClientsTableViewModelType.self) as? ClientTableViewModel
        clientTableVC.viewModel = clientTableVM
        clientTableVC.handleAddClientPress = runCreateClientFlow
        self.didFinishSaveClient = clientTableVM?.getClients
        navigator.setRootModule(module: clientTableVC, hideNavBar: false)
    }
    
    func runCreateClientFlow() {
        let createClientCoordinator = coordinatorFactory.makeCreateClientCoordinator(navigator: navigator)
        addDependency(coordinator: createClientCoordinator)
        
        createClientCoordinator.finishFlow = { [weak self] in
            self?.navigator.dismissModule()
            self?.removeDependency(coordinator: createClientCoordinator)
        }
        
        createClientCoordinator.finishFlowAndUpdate = { [weak self] in
            self?.navigator.dismissModule()
            self?.didFinishSaveClient?()
            self?.removeDependency(coordinator: createClientCoordinator)
        }
        
        createClientCoordinator.start()
    }
}
