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
             
    init(factory: ClientViewControllerFactoryType, navigator: NavigatorType, coordinatorFactory: CoordinatorFactoryType) {
        self.navigator = navigator
        self.factory = factory
        self.coordinatorFactory = coordinatorFactory
    }
    
    private var container: Container {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.container
    }
    
    override func start() {
        showClientTable()
    }
    
    func showClientTable() {
        let clientTableVC = factory.makeClientViewController()
        var clientTableVM = container.resolve(ClientsTableViewModelType.self)
        
        clientTableVM?.didSelectRowAt = { [weak self] client in
            self?.showClientDetails(client: client, delegate: clientTableVM as! ClientTableViewModelDelegate)
        }
        clientTableVM?.didSaveClient = { [weak self] in
            self?.runCreateClientFlow()
        }
        
        clientTableVC.viewModel = clientTableVM
        
        navigator.setRootModule(module: clientTableVC, hideNavBar: false)
    }
    
    func showClientDetails(client: Client?, delegate: ClientTableViewModelDelegate) {
        let clientDetailsVC = factory.makeClientDetailsViewController(delegate: delegate)
        var clientDetailsVM = container.resolve(ClientDetailsViewModelType.self)
        
        clientDetailsVM?.client = client
        clientDetailsVM?.didDeleteClient = { [weak self] in
            self?.navigator.popModule()
            delegate.updateTable()
        }

        clientDetailsVM?.didPressEditClient = { [weak self] in
            self?.showEditClientScreen(client: client, delegate: delegate)
        }
        
        clientDetailsVC.viewModel = clientDetailsVM

        navigator.navigate(module: clientDetailsVC)
    }
    
    func showEditClientScreen(client: Client?, delegate: ClientTableViewModelDelegate) {
        guard let clientToUpdate = client else { return }
        let editClientVC = factory.makeEditClientViewController(client: clientToUpdate, delegate: delegate)
        var editClientVM = container.resolve(EditClientViewModelType.self)
        editClientVM?.didPressSave = { [weak self] in
            self?.navigator.popModule()
            delegate.updateTable()
        }
        editClientVM?.client = client
        editClientVC.viewModel = editClientVM
        navigator.navigate(module: editClientVC)
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
