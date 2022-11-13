//
//  NetworkLogger.swift
//  Nutritional
//
//  Created by Moein Barzegaran on 11/13/22.
//

import Foundation

class Logger {
    class func log(_ items: Any..., separator: String = " ", terminator: String = "\n") {
        #if DEBUG
        Swift.print(items[0], separator:separator, terminator: terminator)
        #endif
    }
}

class NetworkLogger {
    static func log(request: URLRequest, data: Data?, response: HTTPURLResponse) {
        Logger.log("\n - - - - - - - - - - OUTGOING - - - - - - - - - - \n")
        defer { Logger.log("\n - - - - - - - - - -  END - - - - - - - - - - \n") }
        
        Logger.log("🔥🔥🔥 Request URL 🔥🔥🔥")
        Logger.log(request)
        Logger.log("- - - - - - - - - - Request Method - - - - - - - - - -")
        Logger.log(request.httpMethod ?? "")
        Logger.log("- - - - - - - - - - Request Headers - - - - - - - - - -")
        request.allHTTPHeaderFields?
            .map { "\($0): \($1)" }
            .forEach { Logger.log($0) }
        
        request.httpBody
            .map { String(decoding: $0, as: UTF8.self) }
            .map { Logger.log("- - - - - - - - - - Request Body - - - - - - - - - -\n\($0)") }
        
        Logger.log("- - - - - - - - - - Response Status Code - - - - - - - - - -")
        Logger.log(response.statusCode)
        Logger.log("- - - - - - - - - - - - - - - - - - - - - - - - - - - - - -")
        
        data
            .flatMap { try? JSONSerialization.jsonObject(with: $0, options: .allowFragments) }
            .flatMap { try? JSONSerialization.data(withJSONObject: $0, options: .prettyPrinted) }
            .map { String(decoding: $0, as: UTF8.self) }
            .map { "🔥🔥🔥 Response 🔥🔥🔥\n\($0)" }
            .map { Logger.log($0) }
    }

    static func log(response: URLResponse) {}
}
