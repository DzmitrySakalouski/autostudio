//
//  ClientType.swift
//  autostudio
//
//  Created by Dzmitry  Sakalouski  on 20.02.21.
//

import Foundation

protocol ClientType {
    var id: Int? { get }
    var fullName: String { get set }
    var car: String { get set }
    var phoneNumber: String { get set }
    var createdAt: String { get set }
}

protocol ClientListType {
    var clients: [Client] {get set}
    var totalCount: Int { get set }
}
