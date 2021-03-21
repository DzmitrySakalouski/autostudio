//
//  CreateClientService.swift
//  autostudio
//
//  Created by Dzmitry  Sakalouski  on 11.03.21.
//

import RxSwift

class CreateClientService: CreateClientServiceType {
    var apiClient: APIClientType!
    
    init(apiClient: APIClientType) {
        self.apiClient = apiClient
    }
    
    func submitClient(client: Client) -> Observable<Client> {
        return apiClient.callWithBody(endpoint: ClientEndpoints.createClient.endpoint, body: client).observe(on: MainScheduler.instance)
    }
}
