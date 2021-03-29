//
//  ClientEndpoints.swift
//  autostudio
//
//  Created by Dzmitry  Sakalouski  on 20.02.21.
//

import Foundation

enum ClientEndpoints {
    case getAll
    case updateClient
    case deleteClient(id: Int)
    case createClient
    
    var endpoint: Endpoint {
        switch self {
        case .getAll:
            return Endpoint(path: "/api/clients", parameters: getParameters([]), method: .get)
        case .createClient:
            return Endpoint(path: "/api/clients", parameters: getParameters([]), method: .post)
        case .deleteClient(let id):
            let params = [URLQueryItem(name: "clientId", value: String(describing: id))]
            return Endpoint(path: "/api/clients", parameters: getParameters(params), method: .delete)
        case .updateClient:
            return Endpoint(path: "/api/clients", parameters: getParameters([]), method: .post)
        }
    }
    
    func getParameters(_ parameters: [URLQueryItem]) -> [URLQueryItem] {
        return defaultParams + parameters
    }
}
