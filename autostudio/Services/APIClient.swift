//
//  APIService.swift
//  autostudio
//
//  Created by Dzmitry  Sakalouski  on 15.03.21.
//

import Foundation
import RxSwift

class APIClient: APIClientType {
    private let disposeBag: DisposeBag = DisposeBag()
    var networkService: NetworkServiceType!
    
    init(networkService: NetworkServiceType) {
        self.networkService = networkService
    }
    
    func call<T: Codable>(endpoint: EndpointType) -> Observable<T> {
        return Observable<T>.create { [weak self] observer in
            self?.networkService.makeRequest(endpoint: endpoint) { (result: Result<T, Error>) in
                print(result)
                switch result {
                case .success(let data):
                    print("Succ")
                    observer.onNext(data)
                case .failure(let error):
                    print("error")
                    observer.onError(error)
                }
            }
            return Disposables.create()
        }
    }
    
    func callWithBody<T: Codable>(endpoint: EndpointType, body: T) -> Observable<T> {
        return Observable<T>.create { [weak self] observer in
            print("BODY API --->", body)
            self?.networkService.makeRequestWithBody(endpoint: endpoint, body: body) { (result: Result<T, Error>) in
                switch result {
                case .success(let data):
                    print("Succ")
                    observer.onNext(data)
                case .failure(let error):
                    print("error")
                    observer.onError(error)
                }
            }
            return Disposables.create()
        }
    }
}
