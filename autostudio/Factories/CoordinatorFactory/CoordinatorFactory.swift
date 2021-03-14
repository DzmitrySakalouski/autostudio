//
//  CoordinatorFactory.swift
//  autostudio
//
//  Created by Dzmitry  Sakalouski  on 20.02.21.
//

import Foundation

class CoordinatorFactory: CoordinatorFactoryType {
    func makeCreateClientCoordinator(navigator: NavigatorType) -> CreateClientCoordinator {
        let factory = ViewControllerFactory()
        return CreateClientCoordinator(factory: factory, navigator: navigator)
    }
    
    func makeClientCoordinator(navigator: NavigatorType, coordinatorFactory: CoordinatorFactoryType) -> ClientCoordinator {
        let factory = ViewControllerFactory()
        return ClientCoordinator(factory: factory, navigator: navigator, coordinatorFactory: coordinatorFactory)
    }
}
