//
//  NetworkWeatherReportRepositoryMock.swift
//  WeatherApp
//
//  Created by Aleksandra Kustra on 14/12/2025.
//

import Foundation
@testable import WeatherApp

final class NetworkWeatherReportRepositoryMock: NetworkWeatherReportLoading {
    var reportToReturn: WeatherReportModel?
    var shouldThrow = false
    var reports: [String: WeatherReportModel] = [:]

    func fetchReport(for airportIdentifier: String) async throws -> WeatherReportModel {
        if shouldThrow { throw NSError(domain: "Network", code: 1) }
        if let report = reports[airportIdentifier] { return report }
        if let report = reportToReturn { return report }
        throw NSError(domain: "Network", code: 2)
    }
}
