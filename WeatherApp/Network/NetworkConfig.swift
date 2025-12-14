//
//  NetworkConfig.swift
//  WeatherApp
//
//  Created by Aleksandra Kustra on 10/12/2025.
//

import Foundation

protocol NetworkConfig {
    var baseURL: URL { get }
    var headers: [String: String] { get }
}
