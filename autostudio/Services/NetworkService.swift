//
//  NetworkService.swift
//  autostudio
//
//  Created by Dzmitry  Sakalouski  on 20.02.21.
//

import Foundation

class NetworkService: NetworkServiceType {
    func makeRequestWithBody<T: Codable>(endpoint: EndpointType, body: T, complition: @escaping (Result<T, Error>) -> ()) {
        
        let session = URLSession(configuration: URLSessionConfiguration.default)
        guard var request = buildRequest(endpoint: endpoint) else {
            return
        }
        
        do {
            let jsonBody = try JSONEncoder().encode(body)
            print("JSON BODY ===>", print(String(data: jsonBody, encoding: .utf8)!))
            request.httpBody = jsonBody
        } catch {
            print(error)
        }
        
        let dataTask = session.dataTask(with: request) { data, response, error in
            if let error = error {
                complition(.failure(error))
            }
                        
            if let data = data {
                do {
                    let responseData = try JSONDecoder().decode(T.self, from: data)
                    complition(.success(responseData))
                } catch let error {
                    complition(.failure(error))
                }
            }
        }
        
        dataTask.resume()
    }
    
    func makeRequest<T: Codable>(endpoint: EndpointType, complition: @escaping (Result<T, Error>) -> ()) {
        let session = URLSession(configuration: URLSessionConfiguration.default)
        guard let request = buildRequest(endpoint: endpoint) else {
            return
        }
        let dataTask = session.dataTask(with: request) { data, response, error in
            if let error = error {
                complition(.failure(error))
            }
            
            print("data -> ", data)
            print("ERR ->", T.self)
            
            guard let data = data else { return }
            print(data)
//            if let data = data {
                do {
                    let responseData = try JSONDecoder().decode(T.self, from: data)
                    print(responseData)
                    complition(.success(responseData))
                } catch let error {
                    complition(.failure(error))
                }
//            }
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
        
        
        urlRequest.httpMethod = endpoint.method.rawValue
        urlRequest.setValue("application/json", forHTTPHeaderField: "content-type")
        
        return urlRequest
    }
}
