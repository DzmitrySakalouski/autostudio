//
//  CoordinatorFactoryType.swift
//  autostudio
//
//  Created by Dzmitry  Sakalouski  on 20.02.21.
//

import Foundation

protocol CoordinatorFactoryType {
    func makeClientCoordinator(navigator: NavigatorType, coordinatorFactory: CoordinatorFactoryType) -> ClientCoordinator
    func makeCreateClientCoordinator(navigator: NavigatorType) -> CreateClientCoordinator
}
