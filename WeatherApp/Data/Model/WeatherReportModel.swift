//
//  WeatherReportModel.swift
//  WeatherApp
//
//  Created by Aleksandra Kustra on 10/12/2025.
//

import Foundation

struct WeatherReportModel: Codable {
    let report: Report
}

struct Report: Codable {
    let conditions: Conditions?
    let forecast: Forecast?
    let windsAloft: WindsAloft?
    let mos: MOS?
}

struct Conditions: Codable {
    let text: String?
    let ident: String?
    let dateIssued: String?
    let lat: Double?
    let lon: Double?
    let elevationFt: Double?
    let tempC: Double?
    let dewpointC: Double?
    let pressureHg: Double?
    let pressureHpa: Double?
    let reportedAsHpa: Bool?
    let densityAltitudeFt: Double?
    let relativeHumidity: Int?
    let flightRules: String?
    let cloudLayers: [CloudLayer]?
    let cloudLayersV2: [CloudLayer]?
    let weather: [String]?
    let visibility: Visibility?
    let wind: Wind?
    let remarks: Remarks?
    let longestRunway: Int?
}

struct CloudLayer: Codable {
    let coverage: String?
    let altitudeFt: Double?
    let ceiling: Bool?
}

struct Visibility: Codable {
    let distanceSm: Double?
    let distanceMeter: Double?
    let prevailingVisSm: Double?
    let prevailingVisMeter: Double?
    let visReportedInMetric: Bool?
}

struct Wind: Codable {
    let speedKts: Double?
    let direction: Int?
    let from: Int?
    let variable: Bool?
}

struct Remarks: Codable {
    let precipitationDiscriminator: Bool?
    let humanObserver: Bool?
    let seaLevelPressure: Double?
    let sixHourMaximumTemperature: Double?
    let sixHourMinimumTemperature: Double?
    let pressureTendancyRate: Double?
    let pressureTendancyCharacteristics: String?
    let temperature: Double?
    let dewpoint: Double?
    let visibility: [String: String]?
    let sensoryStatus: [String]?
    let lightning: [String]?
    let weatherBeginEnds: [String: String]?
    let clouds: [String]?
    let obscuringLayers: [String]?
    let maintenanceNeeded: Bool?
}

struct Forecast: Codable {
    let text: String?
    let ident: String?
    let dateIssued: String?
    let period: Period?
    let lat: Double?
    let lon: Double?
    let elevationFt: Double?
    let conditions: [ForecastCondition]?
}

struct ForecastCondition: Codable {
    let text: String?
    let dateIssued: String?
    let lat: Double?
    let lon: Double?
    let elevationFt: Double?
    let relativeHumidity: Int?
    let flightRules: String?
    let cloudLayers: [CloudLayer]?
    let cloudLayersV2: [CloudLayer]?
    let weather: [String]??
    let visibility: Visibility?
    let wind: Wind??
    let period: Period?
}

struct Period: Codable {
    let dateStart: String?
    let dateEnd: String?
}

struct WindsAloft: Codable {
    let lat: Double?
    let lon: Double?
    let dateIssued: String?
    let windsAloft: [WindAloftEntry]?
    let source: String?
}

struct WindAloftEntry: Codable {
    let validTime: String?
    let period: Period?
    let windTemps: [String: WindTemp]?
}

struct WindTemp: Codable {
    let directionFromTrue: Int?
    let knots: Int?
    let celsius: Int?
    let altitude: Int?
    let isLightAndVariable: Bool?
    let isGreaterThan199Knots: Bool?
    let turbulence: Bool?
    let icing: Bool?
}

struct MOS: Codable {
    let station: String?
    let issued: String?
    let period: Period?
    let latitude: Double?
    let longitude: Double?
    let forecast: MOSForecast?
}

struct MOSForecast: Codable {
    let text: String?
    let ident: String?
    let dateIssued: String?
    let period: Period?
    let lat: Double?
    let lon: Double?
    let elevationFt: Double?
    let conditions: [MOSCondition]?
}

struct MOSCondition: Codable {
    let text: String?
    let tempMinC: Double?
    let tempMaxC: Double?
    let dewpointMinC: Double?
    let dewpointMaxC: Double?
    let flightRules: String?
    let cloudLayers: [CloudLayer]?
    let cloudLayersV2: [CloudLayer]?
    let weather: [String]?
    let visibility: Visibility?
    let wind: Wind?
    let period: Period?
    let turbulence: [String]?
    let icing: [String]?
}
