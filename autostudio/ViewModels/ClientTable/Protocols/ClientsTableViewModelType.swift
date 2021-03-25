//
//  ClientsTableViewModelType.swift
//  autostudio
//
//  Created by Dzmitry  Sakalouski  on 20.02.21.
//

import Foundation
import RxCocoa
import RxSwift

protocol ClientsTableViewModelType {
    var clientService: ClientTableServiceType { get set }
    var clients: BehaviorRelay<[Client]> { get set }
    var errorMsg: BehaviorRelay<String?> { get set }
    var didSaveClient: (() -> ())? { get set }
    var didSelectRowAt: ((_ client: Client) -> Void)? { get set }
    func cellViewModel(client: Client) -> ClientCellViewModel?
    func getClients() -> Void
    func handleSelectClient(indexPath: IndexPath) -> Void
}
