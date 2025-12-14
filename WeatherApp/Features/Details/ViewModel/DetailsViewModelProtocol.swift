//
//  DetailsViewModelProtocol.swift
//  WeatherApp
//
//  Created by Aleksandra Kustra on 14/12/2025.
//


protocol DetailsViewModelProtocol {
    // MARK: - General info
    var station: String { get }
    var issued: String { get }
    var period: String { get }
    var latitude: String { get }
    var longitude: String { get }
    
    // MARK: - Conditions
    var text: String { get }
    var dateIssued: String { get }
    var elevationFt: String { get }
    var tempC: String { get }
    var dewpointC: String { get }
    var pressureHg: String { get }
    var pressureHpa: String { get }
    var densityAltitudeFt: String { get }
    var relativeHumidity: String { get }
    var flightRules: String { get }
    var cloudLayers: String { get }
    var cloudLayersV2: String { get }
    var weather: String { get }
    var visibility: String { get }
    var wind: String { get }
    var longestRunway: String { get }
    
    // MARK: - Forecast
    var forecastText: String { get }
    var forecastDateIssued: String { get }
    var forecastPeriod: String { get }
    var forecastElevationFt: String { get }
    var forecastConditions: String { get }
}
