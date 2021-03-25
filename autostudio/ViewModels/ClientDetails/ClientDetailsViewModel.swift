//
//  ClientDetailsViewModel.swift
//  autostudio
//
//  Created by Dzmitry  Sakalouski  on 25.03.21.
//

import Foundation

class ClientDetailsViewModel: ClientDetailsViewModelType {
    var client: Client?
    
    func deleteClient() {
        guard let clientId = client?.id else { return }
        print("Client \(clientId) is removed")
    }
    
    func editClient() {
        guard let clientId = client?.id else { return }
        print("Navigate to edit Client \(clientId)")
    }
    
    
}
