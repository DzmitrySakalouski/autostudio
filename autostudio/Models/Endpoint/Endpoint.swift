//
//  Endpoint.swift
//  autostudio
//
//  Created by Dzmitry  Sakalouski  on 20.02.21.
//

import Foundation

struct Endpoint: EndpointType {
    
    var baseUrl: String = BASE_URL
    
    var path: String
    
    var parameters: [URLQueryItem]
    
    var method: HTTPMethod
}
