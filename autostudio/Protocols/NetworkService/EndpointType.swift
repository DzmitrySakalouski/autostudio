//
//  EndpointType.swift
//  autostudio
//
//  Created by Dzmitry  Sakalouski  on 20.02.21.
//

import Foundation

protocol EndpointType {
    var path: String { get }
    
    var parameters: [URLQueryItem] { get set }
    
    var method: HTTPMethod { get }
    
    var body: Decodable? { get set }
}
