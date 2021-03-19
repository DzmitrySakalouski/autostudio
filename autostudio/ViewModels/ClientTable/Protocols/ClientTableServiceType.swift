//
//  ClientTableServiceType.swift
//  autostudio
//
//  Created by Dzmitry  Sakalouski  on 20.02.21.
//

import RxSwift

protocol ClientTableServiceType {
    var apiClient: APIClientType { get set }
    func fetchClients() -> Observable<[Client]>
}
