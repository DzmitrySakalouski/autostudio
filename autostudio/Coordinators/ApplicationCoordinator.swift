//
//  ApplicationCoordinator.swift
//  autostudio
//
//  Created by Dzmitry  Sakalouski  on 20.02.21.
//

import Foundation

class ApplicationCoordinator: BaseCoordinator {
    private let coordinatorFacrory: CoordinatorFactoryType
    private let navigator: NavigatorType
    
    init(coordinatorFacrory: CoordinatorFactoryType, navigator: NavigatorType) {
        self.coordinatorFacrory = coordinatorFacrory
        self.navigator = navigator
    }
    
    override func start() {
        runClientFlow()
    }
    
    func runClientFlow () {
        let coordinatorFactory = CoordinatorFactory()
        let coordinator = coordinatorFacrory.makeClientCoordinator(navigator: navigator, coordinatorFactory: coordinatorFactory)
        addDependency(coordinator: coordinator)
        coordinator.start()
    }
}
