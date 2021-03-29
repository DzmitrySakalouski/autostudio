//
//  ClientServiceType.swift
//  autostudio
//
//  Created by Dzmitry  Sakalouski  on 29.03.21.
//

import RxCocoa
import RxSwift

protocol ClientServiceType {
    var clients: BehaviorRelay<[Client]> { get set }
    var apiClient: APIClientType! { get }
    func getClients() -> Void
    func deleteClient(clientId: Int) -> Observable<String>
    func createClient(client: Client) -> Observable<Client>
    func updateClient(client: Client) -> Observable<Client>
}
