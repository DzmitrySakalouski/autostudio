//
//  CreateClientViewModelType.swift
//  autostudio
//
//  Created by Dzmitry  Sakalouski  on 11.03.21.
//

import Foundation

protocol CreateClientViewModelType {
    var name: String? { get set }
    var car: String? { get set }
    var phoneNumber: String? { get set }
    var closeModalAction: (() -> ())? { get set }
    func sumbitClient(complition: @escaping () -> ()) -> ()
}
