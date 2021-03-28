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
        guard let delegateModel = clientTableVC.viewModel else {
            return
        }
        
        clientTableVC.viewModel?.didSelectRowAt = { [weak self] client in
            self?.showClientDetails(client: client, delegate: delegateModel as! ClientTableViewModelDelegate)
        }
        clientTableVC.viewModel?.didSaveClient = { [weak self] in
            self?.runCreateClientFlow(didFinishCreationFlow: delegateModel.getClients)
        }
        navigator.setRootModule(module: clientTableVC, hideNavBar: false)
    }
    
    func showClientDetails(client: Client?, delegate: ClientTableViewModelDelegate) {
        let clientDetailsVC = factory.makeClientDetailsViewController(delegate: delegate)
        clientDetailsVC.viewModel?.client = client
        clientDetailsVC.viewModel?.didDeleteClient = { [weak self] in
            self?.navigator.popModule()
        }
        
        clientDetailsVC.viewModel?.didPressEditClient = { [weak self] in
            self?.showEditClientScreen(client: client, delegate: delegate)
        }
        
        navigator.navigate(module: clientDetailsVC)
    }
    
    func showEditClientScreen(client: Client?, delegate: ClientTableViewModelDelegate) {
        guard let clientToUpdate = client else { return }
        let editClientVC = factory.makeEditClientViewController(client: clientToUpdate, delegate: delegate)
        var editClientVM = container.resolve(EditClientViewModelType.self)
        editClientVM?.client = client
        editClientVC.viewModel = editClientVM
        navigator.navigate(module: editClientVC)
    }
        
    func runCreateClientFlow(didFinishCreationFlow: (() -> ())?) {
        let createClientCoordinator = coordinatorFactory.makeCreateClientCoordinator(navigator: navigator)
        addDependency(coordinator: createClientCoordinator)
        
        createClientCoordinator.finishFlow = { [weak self] in
            self?.navigator.dismissModule()
            self?.removeDependency(coordinator: createClientCoordinator)
        }
        
        createClientCoordinator.finishFlowAndUpdate = { [weak self] in
            self?.navigator.dismissModule()
            didFinishCreationFlow?()
            self?.removeDependency(coordinator: createClientCoordinator)
        }
        
        createClientCoordinator.start()
    }
}
