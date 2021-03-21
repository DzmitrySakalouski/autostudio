//
//  ClientTableService.swift
//  autostudio
//
//  Created by Dzmitry  Sakalouski  on 20.02.21.
//

import RxSwift

class ClientTableService: ClientTableServiceType {
    var apiClient: APIClientType!
    
    init(apiClient: APIClientType) {
        self.apiClient = apiClient
    }
    
    func fetchClients() -> Observable<[Client]> {
        return apiClient.call(endpoint: ClientEndpoints.getAll.endpoint).map{(clientRespose: ClientList) in
            return clientRespose.clients
        }.observe(on: MainScheduler.instance)
    }
}
