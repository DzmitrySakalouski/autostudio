//
//  CreateClientServiceType.swift
//  autostudio
//
//  Created by Dzmitry  Sakalouski  on 21.03.21.
//

import RxSwift

protocol CreateClientServiceType {
    var apiClient: APIClientType! { get set }
    func submitClient(client: Client) -> Observable<Client>
}
