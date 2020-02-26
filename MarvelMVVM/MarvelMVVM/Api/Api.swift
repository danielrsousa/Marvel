//
//  Api.swift
//  MarvelMVVM
//
//  Created by Daniel Rocha on 26/02/20.
//  Copyright © 2020 Daniel Rocha. All rights reserved.
//

import Foundation

protocol ApiProtocol {
    typealias ResultCompletion<R> = (Result<R, ApiError>) -> Void
    func request<R: Codable>(request: ApiRequestProtocol, result: @escaping ResultCompletion<R>) throws
}

protocol ApiRequestProtocol: Codable {
    var baseURL: URL { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: [String: String]? { get }
    var parameters: [String: Any] { get }
}

class Api: ApiProtocol {
    private let session = URLSession(configuration: .default)
    private var dataTask: URLSessionDataTask?
    
    func request<R: Codable>(request: ApiRequestProtocol, result: @escaping ResultCompletion<R>) throws {
        dataTask?.cancel()
        
        let url = try createURL(request)

        var urlRequest = URLRequest(url: url)
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpMethod = request.method.rawValue
        urlRequest.allHTTPHeaderFields = request.headers
        urlRequest.httpBody = try createBody(request)
        
        dataTask = session.dataTask(with: urlRequest, completionHandler: { [weak self] (data, response, error) in
            defer { self?.dataTask = nil }
            
            guard let http = response as? HTTPURLResponse else {
                print("❌ Problemas de conexão")
                result(.failure(ApiError.connectionFailure))
                return
            }
            
            guard let status = HTTPStatusCode(rawValue: http.statusCode), let data = data else {
                print("❌ Falha ao converter status code ou data")
                result(.failure(ApiError.connectionFailure))
                return
            }
            
            self?.printJson(http.statusCode, data: data)
            let model = try? JSONDecoder().decode(R.self, from: data) as R
            
            switch status {
            case .ok:
                result(.success(model!))
            case .unauthorized:
                print("❌ Não autorizado")
                result(.failure(ApiError.unauthorized))
            case .badRequest:
                print("❌ Requisição mal sucedida")
                result(.failure(ApiError.badRequest))
            default:
                if let error = error {
                    print("❌ Erro de requisição \(error.localizedDescription)")
                    result(.failure(ApiError.requestError(error)))
                    return
                }
                
                result(.failure(ApiError.unknown))
            }
            
        })
        
        dataTask?.resume()
    }
    
    private func createURL(_ request: ApiRequestProtocol) throws -> URL {
        let requestUrl = "\(request.baseURL)\(request.path)"
        var component = URLComponents(string: requestUrl)
        
        if request.method == .get && !request.parameters.isEmpty {
            component?.queryItems = request.parameters.map {
                URLQueryItem(name: $0.key, value: "\($0.value)")
            }
        }
        
        guard let url = component?.url else {
            print("❌ Problemas ao converter url")
            throw ApiError.malformedRequest
        }
        
        return url
    }
    
    private func createBody(_ request: ApiRequestProtocol) throws -> Data? {
        guard  request.method != .get else { return nil }
        return try JSONSerialization.data(withJSONObject: request.parameters)
    }
    
    private func printJson(_ status: Int, data: Data) {
        if let json = try? JSONSerialization.jsonObject(with: data, options: []) {
            print("✅ Status: \(status) Response: \(json)")
        }
    }
}


