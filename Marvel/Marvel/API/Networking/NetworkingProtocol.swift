//
//  AbstractNetworking.swift
//
//  Created by Daniel Sousa on 09/03/18.
//  Copyright © 2018 Daniel Sousa. All rights reserved.
//

import Foundation

typealias NetworkSuccessBlock<R> = (_ responseObject: R?) -> ()?
typealias NetworkFailureBlock = (NetworkingError?) -> ()

protocol NetworkingProtocol: AnyObject {
    
    func doGet<P: AbstractRequest, R: ResponseProtocol>(requestObject: P,
                                                        success: @escaping NetworkSuccessBlock<R>,
                                                        failure: @escaping NetworkFailureBlock)
    
    func doPost<P: AbstractRequest, R: ResponseProtocol>(requestObject: P,
                                                         success: @escaping NetworkSuccessBlock<R>,
                                                         failure: @escaping NetworkFailureBlock)
}
