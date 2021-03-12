//
//  ClientTableViewModel.swift
//  autostudio
//
//  Created by Dzmitry  Sakalouski  on 20.02.21.
//

import Foundation
import RxCocoa

class ClientTableViewModel: ClientsTableViewModelType {    
    internal var clientService: ClientTableServiceType
    internal var clients: [Client]?
    var selectedIndexPath: IndexPath?
    var errorMessage: String?
    var errorMsg: BehaviorRelay<String?> = BehaviorRelay<String?>(value: nil)
    
    init() {
        clientService = ClientTableService()
    }
    
    func numberOfRows() -> Int {
        return clients?.count ?? 0
    }
    
    func cellViewModel(forIndexPath indexPath: IndexPath) -> ClientCellViewModel? {
        guard let client = clients?[indexPath.row] else { return nil }
        return ClientCellViewModel(client: client)
    }
    
    func fetchClients(complition: @escaping () -> ()) {
        clientService.getClients { [weak self] result in
            print("REQUEST")
            switch result {
            case .success(let clients):
                print(clients.clients)
                self?.clients = clients.clients
                if clients.clients.count == 0 {
                    self?.errorMsg.accept("Нет клиентов")
                }
                complition()
            case .failure(let error):
                self?.errorMsg.accept(error.localizedDescription)
                complition()
            }
        }
    }
}
