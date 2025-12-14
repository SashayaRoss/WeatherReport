//
//  PersistenceAirportLoading.swift
//  WeatherApp
//
//  Created by Aleksandra Kustra on 14/12/2025.
//

protocol PersistenceAirportLoading {
    func loadAirports() async throws -> [String]
    func addAirport(_ airport: String) async throws
    func clearCache() async throws
}
