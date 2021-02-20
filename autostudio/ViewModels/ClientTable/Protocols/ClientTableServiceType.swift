//
//  ClientTableServiceType.swift
//  autostudio
//
//  Created by Dzmitry  Sakalouski  on 20.02.21.
//

import Foundation

protocol ClientTableServiceType {
    var networkService: NetworkServiceType { get set }
    func getClients(complition: @escaping (Result<ClientList, Error>) -> ())
}
