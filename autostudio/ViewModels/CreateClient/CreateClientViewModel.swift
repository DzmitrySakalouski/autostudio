//
//  CreateClientViewModel.swift
//  autostudio
//
//  Created by Dzmitry  Sakalouski  on 11.03.21.
//

import Foundation

class CreateClientViewModel: CreateClientViewModelType {
    
    var createClientService = CreateClientService()
    var name: String?
    
    var car: String?
    
    var phoneNumber: String?
    
    var errorMessage: [String]!
    
    var closeModalAction: (() -> ())?
    
    func validate() {
        if name == nil {
            errorMessage.append("Please specify name")
        }
        
        if car == nil {
            errorMessage.append("Please specify car")
        }
        
        if car == nil {
            errorMessage.append("Please specify phone")
        }
    }
    
    func generateClient() -> Client? {
        if name == nil || car == nil || phoneNumber == nil {
            return nil
        }
        
        let client = Client(fullName: name!, car: car!, phoneNumber: phoneNumber!)
        
        return client
    }
    
    func sumbitClient(complition: @escaping () -> ()) {
        errorMessage = [String]()
        validate()
        let client = generateClient()
        guard let clientData = client else {
            print(" error")
            return
        }
        createClientService.submitClient(client: clientData) { [weak self] result in
            switch(result) {
            case .success(let client):
                complition()
                print(client)
                self?.closeModalAction?()
            
            case .failure(let error):
                print(error)
                complition()
        }
    }
}
}
