//
//  ClientDetailsService.swift
//  autostudio
//
//  Created by Dzmitry  Sakalouski  on 26.03.21.
//

import RxSwift

class ClientDetailsService: ClientDetailsServiceType {
    var apiClient: APIClientType!
    
    init(apiClient: APIClientType) {
        self.apiClient = apiClient
    }
    
    func deleteClient(clientId: Int) -> Observable<String> {
        return apiClient.call(endpoint: ClientEndpoints.deleteClient(id: clientId).endpoint).observe(on: MainScheduler.instance)
    }
}
