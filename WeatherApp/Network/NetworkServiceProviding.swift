//
//  NetworkServiceProviding.swift
//  WeatherApp
//
//  Created by Aleksandra Kustra on 10/12/2025.
//

import Foundation

protocol NetworkServiceProviding {
    func requestData(with endpointPath: String) async throws -> Data
}
