//
//  NetworkServiceType.swift
//  autostudio
//
//  Created by Dzmitry  Sakalouski  on 20.02.21.
//

import Foundation

protocol NetworkServiceType {
    func makeRequest<T: Codable>(endpoint: EndpointType, complition: @escaping (Result<T, Error>) -> ()) -> ()
}
