//
//  ApiDataNetworkConfig.swift
//  WeatherApp
//
//  Created by Aleksandra Kustra on 10/12/2025.
//

import Foundation

struct ApiDataNetworkConfig: NetworkConfig {
    let baseURL: URL
    let headers: [String: String]

    init(
        baseURL: URL,
        headers: [String: String] = [:])
    {
        self.baseURL = baseURL
        self.headers = headers
    }
}
