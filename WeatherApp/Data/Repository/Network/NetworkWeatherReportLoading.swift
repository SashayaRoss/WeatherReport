//
//  NetworkWeatherReportLoading.swift
//  WeatherApp
//
//  Created by Aleksandra Kustra on 10/12/2025.
//

protocol NetworkWeatherReportLoading {
    func fetchReport(for airportIdentifier: String) async throws -> WeatherReportModel
}
