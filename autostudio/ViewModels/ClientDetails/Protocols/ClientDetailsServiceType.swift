//
//  ClientDetailsServiceType.swift
//  autostudio
//
//  Created by Dzmitry  Sakalouski  on 26.03.21.
//

import RxSwift

protocol ClientDetailsServiceType {
    var apiClient: APIClientType! { get set }
    func deleteClient(clientId: Int) -> Observable<String>
}
