//
//  APIClientType.swift
//  autostudio
//
//  Created by Dzmitry  Sakalouski  on 16.03.21.
//

import RxSwift

protocol APIClientType {
    var networkService: NetworkServiceType! { get set }
    func call<T: Codable>(endpoint: EndpointType) -> Observable<T>
    func callWithBody<T: Codable>(endpoint: EndpointType, body: T) -> Observable<T>
}
