//
//  NetworkService.swift
//  WeatherApp
//
//  Created by Aleksandra Kustra on 10/12/2025.
//

import Foundation

final class NetworkService {
    enum Error: Swift.Error {
        case invalidData(error: Swift.Error)
        case invalidResponse
        case invalidUrl
    }
    
    private let session: NetworkSession
    private let config: NetworkConfig

    init(
        session: NetworkSession = URLSession.shared,
        config: NetworkConfig
    ) {
        self.session = session
        self.config = config
    }
    
    private func urlRequest(with path: String) -> URLRequest? {
        let url = URL(string: config.baseURL.absoluteString + path)
        guard let url = url else {
            return nil
        }
        var request = URLRequest(url: url)
        for (key, value) in config.headers {
            request.setValue(value, forHTTPHeaderField: key)
        }

        return request
    }
}

extension NetworkService: NetworkServiceProviding {
    func requestData(with path: String) async throws -> Data {
        guard let request = urlRequest(with: path) else {
            throw Error.invalidUrl
        }

        do {
            let (data, response) = try await session.data(for: request)

            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                throw Error.invalidResponse
            }
            return data
        } catch {
            throw Error.invalidData(error: error)
        }
    }
}
