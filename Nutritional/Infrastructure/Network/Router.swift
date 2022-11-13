//
//  NetworkService.swift
//  Nutritional
//
//  Created by Moein Barzegaran on 11/8/22.
//

import Combine
import Foundation

struct Router<Endpoint: EndPointType> {
    
    func request<T: Decodable>(_ route: Endpoint,
                               _ decoder: JSONDecoder = JSONDecoder(),
                               session: URLSessionProtocol = URLSession.shared) -> AnyPublisher<T, Error> {
        do {
            let request = try self.buildRequest(from: route)
            return session.dataTask(for: request)
                .mapError { error -> NetworkError in
                    return NetworkError.noInternetConnection
                }
                .tryMap { result in
                    guard let response = result.response as? HTTPURLResponse else {
                        throw NetworkError.noData
                    }
                    
                    #if DEBUG
                    NetworkLogger.log(request: request, data: result.data, response: response)
                    #endif
                    
                    let responseResult = self.handleNetworkResponse(response, result: result.data)
                    switch responseResult {
                    case .success:
                        do {
                            let decodedModel = try decoder.decode(T.self, from: result.data)
                            return decodedModel
                        } catch {
                            throw NetworkError.unableToDecode(error: error)
                        }
                    case .failure(let error):
                        throw error
                    }
                }
                .receive(on: DispatchQueue.main)
                .eraseToAnyPublisher()
        } catch {
            return Fail(error: NetworkError.requestBuildFailed)
                .eraseToAnyPublisher()
        }

    }

    fileprivate func buildRequest(from route: Endpoint) throws -> URLRequest {
        var request = URLRequest(url: route.baseURL.appendingPathComponent("\(route.version)\(route.path)"),
                                 cachePolicy: .reloadIgnoringLocalAndRemoteCacheData)

        request.timeoutInterval = 60
        request.httpMethod = route.httpMethod.rawValue
        do {
            switch route.task {
            case let .requestParameters(urlParameters):

                try self.configureParameters(bodyEncoding: .urlEncoding,
                                             urlParameters: urlParameters,
                                             request: &request)
            }
            return request
        } catch {
            throw error
        }
    }

    fileprivate func configureParameters(bodyEncoding: ParameterEncoding,
                                         urlParameters: Parameters?,
                                         request: inout URLRequest) throws {
        do {
            try bodyEncoding.encode(urlRequest: &request,
                                    urlParameters: urlParameters)
        } catch {
            throw error
        }
    }

    fileprivate func handleNetworkResponse(_ response: HTTPURLResponse, result: Data) -> Result<Int, NetworkError> {
        switch response.statusCode {
        case 200...299:
            return .success(response.statusCode)
        case 403:
            return .failure(.authenticationError)
        case 404:
            return .failure(.badRequest(error: result))
        case 500...599:
            return .failure(.internalServerError)
        default:
            return .failure(.failed(message: "Unknown Error"))
        }
    }
}

enum NetworkError: Error {
    case authenticationError
    case badRequest(error: Data)
    case encodingFailed
    case failed(message: String)
    case internalServerError
    case missingURL
    case noData
    case noInternetConnection
    case requestBuildFailed
    case unableToDecode(error: Error)
    case serverError(msg: String, response: HTTPURLResponse)
}
