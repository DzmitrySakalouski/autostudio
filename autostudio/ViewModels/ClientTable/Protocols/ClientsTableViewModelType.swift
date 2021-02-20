//
//  ClientsTableViewModelType.swift
//  autostudio
//
//  Created by Dzmitry  Sakalouski  on 20.02.21.
//

import Foundation

protocol ClientsTableViewModelType {
    var clientService: ClientTableServiceType { get set }
    var clients: [Client]? { get set }
    var errorMessage: String? { get set }
    func numberOfRows() -> Int
    func fetchClients(complition: @escaping () -> ())
    func cellViewModel(forIndexPath indexPath: IndexPath) -> ClientCellViewModel?
}
