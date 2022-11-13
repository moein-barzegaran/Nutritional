//
//  Endpoint.swift
//  Nutritional
//
//  Created by Moein Barzegaran on 11/8/22.
//

import Foundation

public typealias HTTPHeaders = [String:String]

// EndPoint Type

protocol EndPointType {
    var baseURL: URL { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var task: HTTPTask { get }
    var version: String { get }
}

// HTTP Method

public enum HTTPMethod : String {
    case get = "GET"
}

// HTTP Task

public enum HTTPTask {
    case requestParameters(urlParameters: Parameters?)
}
