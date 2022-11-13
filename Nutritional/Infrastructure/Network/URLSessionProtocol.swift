//
//  URLSessionProtocol.swift
//  Nutritional
//
//  Created by Moein Barzegaran on 11/13/22.
//

import Foundation

protocol URLSessionProtocol {
    func dataTask(for request: URLRequest) -> URLSession.DataTaskPublisher
}

extension URLSession: URLSessionProtocol {
    func dataTask(for request: URLRequest) -> DataTaskPublisher {
        return dataTaskPublisher(for: request) as URLSession.DataTaskPublisher
    }
}
