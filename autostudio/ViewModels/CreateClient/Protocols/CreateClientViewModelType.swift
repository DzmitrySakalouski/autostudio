//
//  CreateClientViewModelType.swift
//  autostudio
//
//  Created by Dzmitry  Sakalouski  on 11.03.21.
//

import Foundation
import RxCocoa

protocol CreateClientViewModelType {
    var createClientService: CreateClientServiceType! { get set }
    var name: BehaviorRelay<String?> { get set }
    var car: BehaviorRelay<String?> { get set }
    var phoneNumber: BehaviorRelay<String?> { get set }
    var errorMessage: BehaviorRelay<String?> { get set }
    var closeModalAction: (() -> ())? { get set }
    func sumbitClient() -> ()
    var didFinishCreateClient: (() -> ())? { get set }
}
