//
//  NetworkServiceMock.swift
//  WeatherApp
//
//  Created by Aleksandra Kustra on 14/12/2025.
//

@testable import WeatherApp
import Foundation

final class NetworkServiceMock: NetworkServiceProviding {
    var data: Data?
    var error: Error?
    
    func requestData(with path: String) async throws -> Data {
        if let error { throw error }
        if let data { return data }
        throw NetworkService.Error.invalidData(error: NSError(domain: "", code: 0))
    }
}
