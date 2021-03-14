//
//  CreateClientViewModel.swift
//  autostudio
//
//  Created by Dzmitry  Sakalouski  on 11.03.21.
//

import Foundation
import RxCocoa

class CreateClientViewModel: CreateClientViewModelType {
    
    var createClientService = CreateClientService()
    var name: BehaviorRelay<String?> = BehaviorRelay<String?>(value: nil)
    
    var car: BehaviorRelay<String?> = BehaviorRelay<String?>(value: nil)
    
    var phoneNumber: BehaviorRelay<String?> = BehaviorRelay<String?>(value: nil)
    
    var errorMessage: BehaviorRelay<String?> = BehaviorRelay<String?>(value: nil)
    
    var closeModalAction: (() -> ())?
    
    func validate() -> Bool {
        print(name.value! == nil, car.value!  == nil, phoneNumber.value! == nil)
        if name.value == nil || name.value! == "" {
            errorMessage.accept("Please specify name")
            return false
        }
        
        if car.value == nil || car.value! == "" {
            errorMessage.accept("Please specify car")
            return false
        }
        
        if phoneNumber.value == nil || phoneNumber.value! == ""  {
            errorMessage.accept("Please specify phone")
            return false
        }
        
        errorMessage.accept(nil)
        return true
    }
    
    func generateClient() -> Client? {
        if name.value == nil || car.value == nil || phoneNumber.value == nil {
            return nil
        }
        
        let client = Client(fullName: name.value!, car: car.value!, phoneNumber: phoneNumber.value!)
        
        return client
    }
    
    func sumbitClient(complition: (() -> ())?) {
        if !validate() { return }

        let client = generateClient()
        guard let clientData = client else {
            return
        }
        createClientService.submitClient(client: clientData) { [weak self] result in
            switch(result) {
            case .success(let client):
                complition?()
                print(client)
                self?.closeModalAction?()

            case .failure(let error):
                print(error)
                complition?()
                self?.closeModalAction?()
            }
        }
    }
}
