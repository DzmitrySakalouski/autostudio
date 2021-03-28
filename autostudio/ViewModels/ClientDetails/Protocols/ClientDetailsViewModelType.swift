//
//  ClientDetailsViewModelType.swift
//  autostudio
//
//  Created by Dzmitry  Sakalouski  on 25.03.21.
//

import Foundation

protocol ClientDetailsViewModelType {
    var client: Client? { get set }
    var delegate: ClientTableViewModelDelegate? { get set }
    var didDeleteClient: (() -> ())? { get set }
    var didPressEditClient: (() -> ())? { get set }
    func deleteClient() -> Void
    func editClient() -> Void
}
