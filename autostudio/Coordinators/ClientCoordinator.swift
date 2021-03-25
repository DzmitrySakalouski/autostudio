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
        
        clientTableVM?.didSelectRowAt = { [weak self] client in
            self?.showClientDetails(client: client)
        }
        clientTableVC.viewModel = clientTableVM
        clientTableVM?.didSaveClient = runCreateClientFlow
        self.didFinishSaveClient = clientTableVM?.getClients
        navigator.setRootModule(module: clientTableVC, hideNavBar: false)
    }
    
    func showClientDetails(client: Client?) {
        let clientDetailsVC = factory.makeClientDetailsViewController()
        var clentDetailsVM = container.resolve(ClientDetailsViewModelType.self)
        clentDetailsVM?.client = client
        clientDetailsVC.viewModel = clentDetailsVM
        navigator.navigate(module: clientDetailsVC)
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
