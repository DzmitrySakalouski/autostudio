//
//  ClientTableService.swift
//  autostudio
//
//  Created by Dzmitry  Sakalouski  on 20.02.21.
//

import Foundation

class ClientTableService: ClientTableServiceType {
    
    var networkService: NetworkServiceType
    
    init() {
        self.networkService = NetworkService()
    }
    
    func getClients(complition: @escaping (Result<ClientList, Error>) -> ()) {
        networkService.makeRequest(endpoint: ClientEndpoints.getAll.endpoint) {(result: Result<ClientList, Error>) in
            switch result {
                case .success(let clients):
                    DispatchQueue.main.async {
                    complition(.success(clients))
                }
                case .failure(let error):
                    DispatchQueue.main.async {
                        complition(.failure(error))
                    }
                }
        }
    }
}
