//
//  ClientEndpoints.swift
//  autostudio
//
//  Created by Dzmitry  Sakalouski  on 20.02.21.
//

import Foundation

enum ClientEndpoints {
    case getAll
    case updateClient(id: Int, client: Client)
    case deleteClient(id: Int)
    case createClient(client: Client)
    
    var endpoint: Endpoint {
        switch self {
        case .getAll:
            return Endpoint(path: "/api/clients", parameters: getParameters([]), method: .get)
        case .createClient(let client):
            return Endpoint(path: "/api/clients", parameters: getParameters([]), method: .post, body: client)
        case .deleteClient(let id):
            let params = [URLQueryItem(name: "clientId", value: String(describing: id))]
            return Endpoint(path: "/api/clients", parameters: getParameters(params), method: .delete, body: nil)
        case .updateClient(let id, let client):
            let params = [URLQueryItem(name: "clientId", value: String(describing: id))]
            return Endpoint(path: "/api/clients", parameters: getParameters(params), method: .delete, body: client)
        }
    }
    
    func getParameters(_ parameters: [URLQueryItem]) -> [URLQueryItem] {
        return defaultParams + parameters
    }
}
