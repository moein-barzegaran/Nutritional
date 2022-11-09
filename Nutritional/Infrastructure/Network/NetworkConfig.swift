//
//  NetworkConfig.swift
//  Nutritional
//
//  Created by Moein Barzegaran on 11/8/22.
//

import Foundation

public protocol NetworkConfigurable {
    var baseURL: URL { get }
}

public struct ApiDataNetworkConfig: NetworkConfigurable {
    public let baseURL: URL
    
     public init(baseURL: URL) {
        self.baseURL = baseURL
    }
}
