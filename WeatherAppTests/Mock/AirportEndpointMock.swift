//
//  AirportEndpointMock.swift
//  WeatherApp
//
//  Created by Aleksandra Kustra on 14/12/2025.
//

@testable import WeatherApp

final class AirportEndpointMock: AirportProviding {
    func getAirportPath(for airport: String) -> String {
        return "/airport/\(airport)"
    }
}
