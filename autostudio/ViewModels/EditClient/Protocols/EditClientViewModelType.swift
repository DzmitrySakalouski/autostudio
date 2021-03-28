//
//  EditClientViewModelType.swift
//  autostudio
//
//  Created by Dzmitry  Sakalouski  on 28.03.21.
//

import RxCocoa

protocol EditClientViewModelType {
    var client: Client? { get set }
    var fullName: BehaviorRelay<String> { get }
    var phoneNumber: BehaviorRelay<String> { get }
    var car: BehaviorRelay<String> { get }
    var didPressSave: (() -> ())? { get set }
    func handleSaveClient() -> ()
    func getUpdatedClient() -> Client
}
