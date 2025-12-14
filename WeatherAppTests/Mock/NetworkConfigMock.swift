//
//  NetworkConfigMock.swift
//  WeatherApp
//
//  Created by Aleksandra Kustra on 14/12/2025.
//

import Foundation
@testable import WeatherApp

struct NetworkConfigMock: NetworkConfig {
    let baseURL: URL
    let headers: [String: String]
}
