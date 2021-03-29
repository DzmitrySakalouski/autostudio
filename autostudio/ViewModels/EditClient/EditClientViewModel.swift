//
//  EditClientViewModel.swift
//  autostudio
//
//  Created by Dzmitry  Sakalouski  on 28.03.21.
//

import RxCocoa

class EditClientViewModel: EditClientViewModelType {
    var client: Client? {
        didSet {
            guard let clientData = client else { return }
            self.fullName.accept(clientData.fullName)
            self.phoneNumber.accept(clientData.phoneNumber)
            self.car.accept(clientData.car)
        }
    }
    var fullName: BehaviorRelay<String> = BehaviorRelay<String>(value: "")
    
    var phoneNumber: BehaviorRelay<String> = BehaviorRelay<String>(value: "")
    
    var car: BehaviorRelay<String> = BehaviorRelay<String>(value: "")
    
    var didPressSave: (() -> ())?
    
    func handleSaveClient() {
        let client = getUpdatedClient()
        print(client)
        didPressSave?()
    }
    
    func getUpdatedClient() -> Client {
        return Client(fullName: self.fullName.value, car: self.car.value, phoneNumber: self.phoneNumber.value)
    }
}
