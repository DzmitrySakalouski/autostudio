//
//  ClientService.swift
//  autostudio
//
//  Created by Dzmitry  Sakalouski  on 29.03.21.
//

import RxCocoa
import RxSwift

class ClientService: ClientServiceType {
    var clients: BehaviorRelay<[Client]> = BehaviorRelay<[Client]>(value: [])
    var apiClient: APIClientType!
    var disposeBag = DisposeBag()
    
    init(apiClient: APIClientType) {
        self.apiClient = apiClient
    }
    
    func getClients() {
        apiClient.call(endpoint: ClientEndpoints.getAll.endpoint).observe(on: MainScheduler.instance).subscribe(onNext: { [weak self] (data: ClientList) in
            self?.clients.accept(data.clients)
        }).disposed(by: disposeBag)
    }
    
    func deleteClient(clientId: Int) -> Observable<String> {
        return apiClient.call(endpoint: ClientEndpoints.deleteClient(id: clientId).endpoint).observe(on: MainScheduler.instance)
    }
    
    func createClient(client: Client) -> Observable<Client> {
        return apiClient.callWithBody(endpoint: ClientEndpoints.createClient.endpoint, body: client).observe(on: MainScheduler.instance)
    }
    
    func updateClient(client: Client) -> Observable<Client> {
        return apiClient.callWithBody(endpoint: ClientEndpoints.updateClient.endpoint, body: client).observe(on: MainScheduler.instance)
    }
}
