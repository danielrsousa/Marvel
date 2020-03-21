//
//  ApiMock.swift
//  MarvelMVVMTests
//
//  Created by Daniel Rocha on 3/20/20.
//  Copyright © 2020 Daniel Rocha. All rights reserved.
//

@testable import MarvelMVVM
import Foundation

struct Stub {
    enum ServerStatus: Int {
        case success = 200
        case failure = 400
    }
    
    var fileName: String
    var status: ServerStatus
}

class ApiMock: ApiProtocol {
    var stub: Stub
    let bundle: Bundle
    
    init(stub: Stub) {
        self.stub = stub
        self.bundle = Bundle(for: type(of: self))
    }
    
    func request<R>(request: ApiRequestProtocol, result: @escaping (Result<R, ApiError>) -> Void) where R : Decodable {
        guard
            let filePath = self.bundle.url(forResource: stub.fileName, withExtension: "json"),
            let content = try? Data(contentsOf: filePath) else {
                DispatchQueue.main.async {
                    result(.failure(.unitTest))
                }
                return
        }

        if let model = try? JSONDecoder().decode(R.self, from: content) as R {
            result(.success(model))
            return
        }
        
        result(.failure(.unitTest))
    }
}
