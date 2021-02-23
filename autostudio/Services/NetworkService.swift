//
//  NetworkService.swift
//  autostudio
//
//  Created by Dzmitry  Sakalouski  on 20.02.21.
//

import Foundation

class NetworkService: NetworkServiceType {
    func makeRequest<T: Codable>(endpoint: EndpointType, complition: @escaping (Result<T, Error>) -> ()) {
        let session = URLSession(configuration: URLSessionConfiguration.default)
        guard let request = buildRequest(endpoint: endpoint) else {
            print("error")
            return
        }
        let dataTask = session.dataTask(with: request) { data, response, error in
            if let error = error {
                print("error")
                complition(.failure(error))
            }
            
            print("req success")
            
            if let data = data {
                print(data)
                do {
                    let responseData = try JSONDecoder().decode(T.self, from: data)
                    print(data)
                    complition(.success(responseData))
                } catch let error {
                    print("fail")
                    print(error)
                    complition(.failure(error))
                }
            }
        }
        
        dataTask.resume()
    }
    
    private func buildRequest(endpoint: EndpointType) -> URLRequest? {
        var components = URLComponents(string: BASE_URL)
        components?.path = endpoint.path
        
        if endpoint.parameters.count != 0 {
            components?.queryItems = endpoint.parameters
        }
        
        guard let urlComponents = components else { return nil }

        guard let url = urlComponents.url else { return nil }
        var urlRequest = URLRequest(url: url)
        
        print(url)
        
        urlRequest.httpMethod = endpoint.method.rawValue
        
        if let body = endpoint.body {
            let jsonBody = try? JSONSerialization.data(withJSONObject: body, options: [])
            urlRequest.httpBody = jsonBody
        }
        
        print("urlRequest")
        
        return urlRequest
    }
}
