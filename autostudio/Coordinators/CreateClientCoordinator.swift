//
//  CreateClientCoordinator.swift
//  autostudio
//
//  Created by Dzmitry  Sakalouski  on 14.03.21.
//

import Foundation

class CreateClientCoordinator: BaseCoordinator, CoordinatorOutputType {
    private let navigator: NavigatorType
    private let factory: ClientViewControllerFactoryType
         
    init(factory: ClientViewControllerFactoryType, navigator: NavigatorType) {
        self.navigator = navigator
        self.factory = factory
    }
    
    override func start() {
        showCreateClientScreen()
    }
    
    var finishFlow: (() -> Void)?
    
    func showCreateClientScreen() {
        let createClientVC = factory.makeCreateClientViewController()
        let createClientVM = CreateClientViewModel()
        
        createClientVM.closeModalAction = finishFlow
        createClientVC.viewModel = createClientVM

        navigator.present(module: createClientVC)
    }
}
