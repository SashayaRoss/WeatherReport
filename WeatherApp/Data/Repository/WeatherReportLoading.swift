//
//  WeatherReportLoading.swift
//  WeatherApp
//
//  Created by Aleksandra Kustra on 13/12/2025.
//

protocol WeatherReportLoading {
    func getWeatherReport(for airport: String) async throws -> WeatherReportModel
    func getReports(for airports: [String]) async throws -> [String: WeatherReportModel]
    func clearCache()
}
