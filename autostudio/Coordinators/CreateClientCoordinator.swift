//
//  CreateClientCoordinator.swift
//  autostudio
//
//  Created by Dzmitry  Sakalouski  on 14.03.21.
//

import Swinject

class CreateClientCoordinator: BaseCoordinator, CoordinatorOutputType {
    private let navigator: NavigatorType
    private let factory: ClientViewControllerFactoryType
    
    private var container: Container {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.container
    }
         
    init(factory: ClientViewControllerFactoryType, navigator: NavigatorType) {
        self.navigator = navigator
        self.factory = factory
    }
    
    override func start() {
        showCreateClientScreen()
    }
    
    var finishFlow: (() -> Void)?
    var finishFlowAndUpdate: (() -> Void)?
    
    func showCreateClientScreen() {
        let createClientVC = factory.makeCreateClientViewController()
        createClientVC.viewModel?.closeModalAction = finishFlow
        createClientVC.viewModel?.didFinishCreateClient = finishFlowAndUpdate
        navigator.present(module: createClientVC)
    }
}
