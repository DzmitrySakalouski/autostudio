//
//  ClientTableViewModel.swift
//  autostudio
//
//  Created by Dzmitry  Sakalouski  on 20.02.21.
//

import Foundation
import RxCocoa
import RxSwift

class ClientTableViewModel: ClientsTableViewModelType {
    internal var clientService: ClientTableServiceType
    var errorMsg: BehaviorRelay<String?> = BehaviorRelay<String?>(value: nil)
    let disposeBag = DisposeBag()
    
    internal var clients: Observable<[Client]>?
    
    init(service: ClientTableServiceType) {
        clientService = service
        clients = clientService.fetchClients().observe(on: MainScheduler.instance)
    }
    
    func cellViewModel(client: Client) -> ClientCellViewModel? {
        return ClientCellViewModel(client: client)
    }
    
}
