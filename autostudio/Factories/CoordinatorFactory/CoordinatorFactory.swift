//
//  CoordinatorFactory.swift
//  autostudio
//
//  Created by Dzmitry  Sakalouski  on 20.02.21.
//

import Foundation

class CoordinatorFactory: CoordinatorFactoryType {
    func makeClientCoordinator(navigator: NavigatorType) -> ClientCoordinator {
        let factory = ViewControllerFactory()
        return ClientCoordinator(factory: factory, navigator: navigator)
    }
}
