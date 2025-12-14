//
//  WeatherReportsEndpoint.swift
//  WeatherApp
//
//  Created by Aleksandra Kustra on 10/12/2025.
//

final class WeatherReportEndpoint: APIEndpoint {
    func path(for airportIdentifier: String) -> String {
        "weather/report/\(airportIdentifier.lowercased())"
    }
}

extension WeatherReportEndpoint: AirportProviding {
    func getAirportPath(for airportIdentifier: String) -> String {
        path(for: airportIdentifier)
    }
}
