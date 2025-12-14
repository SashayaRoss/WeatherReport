//
//  APIEndpoint.swift
//  WeatherApp
//
//  Created by Aleksandra Kustra on 10/12/2025.
//

protocol APIEndpoint {
    func path(for airportIdentifier: String) -> String
}
