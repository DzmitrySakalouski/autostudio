//
//  ClientDetailsViewModel.swift
//  autostudio
//
//  Created by Dzmitry  Sakalouski  on 25.03.21.
//

import RxSwift

class ClientDetailsViewModel: ClientDetailsViewModelType {
    var delegate: ClientTableViewModelDelegate?
    var client: Client?
    var clientDetailsService: ClientDetailsServiceType!
    private let disposeBag = DisposeBag()
    
    var didDeleteClient: (() -> ())?
    var didPressEditClient: (() -> ())?
    
    init(clientDetailsService: ClientDetailsServiceType) {
        self.clientDetailsService = clientDetailsService
    }
    
    func deleteClient() {
        guard let clientId = client?.id else { return }
        clientDetailsService.deleteClient(clientId: clientId).asObservable().subscribe(onNext: { [weak self] message in
            self?.didDeleteClient?()
            self?.delegate?.updateTable()
        }).disposed(by: disposeBag)
    }
    
    func editClient() {
        didPressEditClient?()
    }
}
