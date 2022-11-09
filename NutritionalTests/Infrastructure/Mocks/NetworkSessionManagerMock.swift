//
//  NetworkSessionManagerMock.swift
//  NutritionalTests
//
//  Created by Moein Barzegaran on 11/8/22.
//

import Foundation

class CancellableNetworkMock: NetworkCancellable {
    func resume() {}
}

struct NetworkSessionManagerMock: NetworkSessionManager {
    let response: HTTPURLResponse?
    let data: Data?
    let error: Error?
    let cancellableNetwork: NetworkCancellable = CancellableNetworkMock()
    
    func request(_ request: URLRequest,
                 completion: @escaping CompletionHandler) -> NetworkCancellable {
        completion(data, response, error)
        return cancellableNetwork
    }
}
