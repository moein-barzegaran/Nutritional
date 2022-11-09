//
//  NetworkConfigurableMock.swift
//  NutritionalTests
//
//  Created by Moein Barzegaran on 11/8/22.
//

import Foundation

class NetworkConfigurableMock: NetworkConfigurable {
    var baseURL: URL = URL(string: "https://mock.test.com")!
    var queryParameters: [String: String] = [:]
}
