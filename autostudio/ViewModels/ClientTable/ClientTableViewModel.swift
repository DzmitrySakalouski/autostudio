//
//  ClientTableViewModel.swift
//  autostudio
//
//  Created by Dzmitry  Sakalouski  on 20.02.21.
//

import Foundation
import RxCocoa
import RxSwift

class ClientTableViewModel: ClientsTableViewModelType, ClientTableViewModelDelegate {
    var didSelectRowAt: ((Client) -> Void)?
    var didSaveClient: (() -> ())?
    internal var clientService: ClientServiceType
    var errorMsg: BehaviorRelay<String?> = BehaviorRelay<String?>(value: nil)
    let disposeBag = DisposeBag()
    var createClientVM: CreateClientViewModel!
        
    init(service: ClientServiceType) {
        clientService = service
    }
    
    internal func retrieveClients() -> BehaviorRelay<[Client]> {
        return clientService.clients
    }
    
    func updateTable() {
        getClients() // TODO: remove
    }
    
    internal func getClients() {
        clientService.getClients()
    }
    
    func cellViewModel(client: Client) -> ClientCellViewModel? {
        return ClientCellViewModel(client: client)
    }
    
    func handleSelectClient(indexPath: IndexPath) {
        guard let selectionHandler = didSelectRowAt else { return }
        let selectedClient = retrieveClients().value[indexPath.row]
        selectionHandler(selectedClient)
    }
    
}
