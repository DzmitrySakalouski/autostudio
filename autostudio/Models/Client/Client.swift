//
//  Client.swift
//  autostudio
//
//  Created by Dzmitry  Sakalouski  on 20.02.21.
//

import Foundation

struct Client: Codable {
    var id: Int?
    var fullName: String
    var car: String
    var phoneNumber: String
    var createdAt: String
    var offerCount: String?
    var totalFeeAmount: String?
}

struct ClientList: Codable {
    var clients: [Client]
}
