//
//  CreateClientViewModel.swift
//  autostudio
//
//  Created by Dzmitry  Sakalouski  on 11.03.21.
//

import Foundation
import RxCocoa
import RxSwift

class CreateClientViewModel: CreateClientViewModelType {
    var createClientService: CreateClientServiceType!
    
    var name: BehaviorRelay<String?> = BehaviorRelay<String?>(value: nil)
    var car: BehaviorRelay<String?> = BehaviorRelay<String?>(value: nil)
    var phoneNumber: BehaviorRelay<String?> = BehaviorRelay<String?>(value: nil)
    
    var errorMessage: BehaviorRelay<String?> = BehaviorRelay<String?>(value: nil)
    var closeModalAction: (() -> ())?
    
    let disposeBag = DisposeBag()
    
    init(createClientService: CreateClientServiceType) {
        self.createClientService = createClientService
    }
    
    func validate() -> Bool {
        if name.value == nil || name.value! == "" {
            print("name.value == nil || name.value!")
            errorMessage.accept("Please specify name")
            return false
        }
        
        if car.value == nil || car.value! == "" {
            print("car.value == nil || car.value! == ")
            errorMessage.accept("Please specify car")
            return false
        }
        
        if phoneNumber.value == nil || phoneNumber.value! == ""  {
            print("phoneNumber.value == nil || phoneNumber.value!")
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
        print("client", client)
        return client
    }
    
    func sumbitClient() {
        print("'SSSSSUUUUBBBB'")
        if validate() {
            guard let client = generateClient() else { return }
            createClientService.submitClient(client: client).asObservable().subscribe(onNext: {[weak self] _ in
                self?.closeModalAction?()
            }).disposed(by: disposeBag)
        }
    }
}
