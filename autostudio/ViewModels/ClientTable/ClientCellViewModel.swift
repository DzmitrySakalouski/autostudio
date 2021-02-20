//
//  ClientCellViewModel.swift
//  autostudio
//
//  Created by Dzmitry  Sakalouski  on 20.02.21.
//

import Foundation

class ClientCellViewModel: ClientCellViewModelType {
    var client: Client
    init (client: Client) {
        self.client = client
    }
}
