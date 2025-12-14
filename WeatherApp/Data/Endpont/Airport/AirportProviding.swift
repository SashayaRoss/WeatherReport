//
//  AirportProviding.swift
//  WeatherApp
//
//  Created by Aleksandra Kustra on 10/12/2025.
//

protocol AirportProviding {
    func getAirportPath(for airportIdentifier: String) -> String
}
