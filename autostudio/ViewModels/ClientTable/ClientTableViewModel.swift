//
//  ClientTableViewModel.swift
//  autostudio
//
//  Created by Dzmitry  Sakalouski  on 20.02.21.
//

import Foundation

class ClientTableViewModel: ClientsTableViewModelType {    
    internal var clientService: ClientTableServiceType
    internal var clients: [Client]?
    var selectedIndexPath: IndexPath?
    var errorMessage: String?
    
    init() {
        clientService = ClientTableService()
    }
    
    func numberOfRows() -> Int {
        return clients?.count ?? 0
    }
    
    func cellViewModel(forIndexPath indexPath: IndexPath) -> ClientCellViewModel? {
        guard let client = clients?[indexPath.row] else { return nil }
        print("==", client)
        return ClientCellViewModel(client: client)
    }
    
    func fetchClients(complition: @escaping () -> ()) {
        clientService.getClients { [weak self] result in
            switch result {
            case .success(let clients):
                self?.clients = clients.clients
                complition()
            case .failure(let error):
                self?.errorMessage = error.localizedDescription
                complition()
            }
        }
    }
}
