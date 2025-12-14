//
//  NetworkSessionMock.swift
//  WeatherApp
//
//  Created by Aleksandra Kustra on 14/12/2025.
//

import Foundation
@testable import WeatherApp

final class NetworkSessionMock: NetworkSession {
    var data: Data?
    var response: URLResponse?
    var error: Error?

    private(set) var receivedRequest: URLRequest?

    func data(for request: URLRequest) async throws -> (Data, URLResponse) {
        receivedRequest = request

        if let error {
            throw error
        }

        guard let data, let response else {
            throw NetworkSessionMockError.notConfigured
        }

        return (data, response)
    }

    enum NetworkSessionMockError: Error {
        case notConfigured
    }
}
