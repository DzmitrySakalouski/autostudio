//
//  ClientTableViewModel.swift
//  autostudio
//
//  Created by Dzmitry  Sakalouski  on 20.02.21.
//

import Foundation
import RxCocoa
import RxSwift

class ClientTableViewModel: ClientsTableViewModelType, UpdateDelegateType {
    internal var clientService: ClientTableServiceType
    var errorMsg: BehaviorRelay<String?> = BehaviorRelay<String?>(value: nil)
    let disposeBag = DisposeBag()
    
    var createClientVM: CreateClientViewModel!
    
    internal var clients: BehaviorRelay<[Client]> = BehaviorRelay<[Client]>(value: [Client]())
    
    init(service: ClientTableServiceType) {
        clientService = service
        createClientVM?.delegate = self
    }
    
    func update() {
        getClients()
    }
    
    func getClients() {
        clientService.fetchClients()?.observe(on: MainScheduler.instance).map{$0.clients}.subscribe(onNext: { [weak self] data in
            print(data.count)
            self?.clients.accept(data)
        }, onError: { [weak self] error in
            self?.errorMsg.accept(error.localizedDescription)
        }).disposed(by: disposeBag)
    }
    
    func cellViewModel(client: Client) -> ClientCellViewModel? {
        return ClientCellViewModel(client: client)
    }
    
}
