//
//  CreateClientService.swift
//  autostudio
//
//  Created by Dzmitry  Sakalouski  on 11.03.21.
//

import Foundation

class CreateClientService {
    var networkService: NetworkServiceType
    
    init() {
        self.networkService = NetworkService()
    }
    
    func submitClient(client: Client, complition: @escaping (Result<Client, Error>) -> ()) {
        networkService.makeRequest(endpoint: ClientEndpoints.createClient(client: client) as! EndpointType) {(result: Result<Client, Error>) in
            switch result {
                case .success(let client):
                    DispatchQueue.main.async {
                        complition(.success(client))
                    }
                case .failure(let error):
                    DispatchQueue.main.async {
                        complition(.failure(error))
                    }
                }
        }
    }
}
