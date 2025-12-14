//
//  WeatherReportCacheProtocol.swift
//  WeatherApp
//
//  Created by Aleksandra Kustra on 14/12/2025.
//

protocol WeatherReportCacheProtocol {
    func set(_ report: WeatherReportModel, for airportIdentifier: String)
    func get(for airportIdentifier: String) -> WeatherReportModel?
    func clear()
}
