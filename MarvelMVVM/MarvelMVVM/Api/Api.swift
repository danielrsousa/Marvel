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
    func request<R: Decodable>(request: ApiRequestProtocol, result: @escaping ResultCompletion<R>)
}

protocol ApiRequestProtocol {
    var baseURL: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: [String: String]? { get }
    var parameters: [String: Any] { get }
}

extension ApiRequestProtocol {
    static func getHashAndTimestamp() -> (timestamp: String, hash: String ) {
        let ts = String.init(format: "%f", NSDate().timeIntervalSince1970).replacingOccurrences(of: ".", with: "")
        let string = String.init(format: "%@%@%@", ts, ServicesInfo.privateKey, ServicesInfo.apiKey)
        return (timestamp: ts, hash: M5.md5(string: string))
    }
}

class Api: ApiProtocol {
    // MARK: - Private Properties
    private let session = URLSession(configuration: .default)
    private var dataTask: URLSessionDataTask?
    
    // MARK: - Internal Methods
    func request<R: Decodable>(request: ApiRequestProtocol, result: @escaping ResultCompletion<R>) {
        dataTask?.cancel()
        
        do {
            let url = try createURL(request)

             var urlRequest = URLRequest(url: url)
             urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
             urlRequest.httpMethod = request.method.rawValue
             urlRequest.allHTTPHeaderFields = request.headers
             urlRequest.httpBody = try createBody(request)
             
            print("🚀 UrlRequest: \(urlRequest)")
            
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
                 default:
                     if let error = error {
                         print("❌ Erro de requisição \(error.localizedDescription)")
                         result(.failure(ApiError.requestError(error)))
                         return
                     }
                     print("❌ Erro de requisição desconhecido")
                     result(.failure(ApiError.unknown))
                 }
                 
             })
             
             dataTask?.resume()
       
        } catch let error {
            print("❌ Lançamento de falha \(error.localizedDescription)")
            guard let error = error as? ApiError else {
                result(.failure(.unknown))
                return
            }
            result(.failure(error))
        }
    }
    
    // MARK: - Private Methods
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
        print("✅ Status: \(status)")
//        if let json = try? JSONSerialization.jsonObject(with: data, options: []) {
//            print("json: \(json)")
//        }
    }
}


