//
//  NetworkSession.swift
//  WeatherApp
//
//  Created by Aleksandra Kustra on 10/12/2025.
//

import Foundation

protocol NetworkSession {
    func data(for request: URLRequest) async throws -> (Data, URLResponse)
}

extension URLSession: NetworkSession {}
