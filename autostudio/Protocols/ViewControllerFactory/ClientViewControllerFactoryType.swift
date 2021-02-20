//
//  ClientViewControllerFactoryType.swift
//  autostudio
//
//  Created by Dzmitry  Sakalouski  on 20.02.21.
//

import Foundation

protocol ClientViewControllerFactoryType {
    func makeClientViewController() -> ClientTableViewController
}
