//
//  ClientDetailsViewModelType.swift
//  autostudio
//
//  Created by Dzmitry  Sakalouski  on 25.03.21.
//

import Foundation

protocol ClientDetailsViewModelType {
    var client: Client? { get set }
    func deleteClient() -> Void
    func editClient() -> Void
}
