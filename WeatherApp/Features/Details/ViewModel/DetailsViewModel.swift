//
//  DetailsViewModel.swift
//  WeatherApp
//
//  Created by Aleksandra Kustra on 10/12/2025.
//

import UIKit

final class DetailsViewModel: DetailsViewModelProtocol {
    enum DisplayMode {
        case conditions
        case forecast
    }
    
    private let airportName: String
    private let weatherReport: WeatherReportModel
    
    init(airport: String, weatherReportEntity: WeatherReportModel) {
        self.airportName = airport
        self.weatherReport = weatherReportEntity
    }
    
    private func formatDate(_ isoDate: String) -> String {
        guard let date = ISO8601DateFormatter().date(from: isoDate) else { return isoDate }
        return DateFormatter.displayDateFormatter.string(from: date)
    }
    
    // MARK: General info
    
    var station: String { airportName.uppercased() }
    
    var issued: String { formatDate(weatherReport.report.mos?.issued ?? "Unknown") }
    
    var period: String {
        let start = formatDate(weatherReport.report.mos?.period?.dateStart ?? "Unknown")
        let end = formatDate(weatherReport.report.mos?.period?.dateEnd ?? "Unknown")
        return "\(start) - \(end)"
    }
    
    var latitude: String {
        if let latitude = weatherReport.report.mos?.latitude {
            return "\(latitude)"
        } else {
            return "Unknown"
        }
    }
    
    var longitude: String {
        if let longitude = weatherReport.report.mos?.longitude {
            return "\(longitude)"
        } else {
            return "Unknown"
        }
    }
    
    // MARK: - Conditions
    
    var text: String { weatherReport.report.conditions?.text ?? "Unknown" }
    
    var dateIssued: String { formatDate(weatherReport.report.conditions?.dateIssued ?? "Unknown") }
    
    var elevationFt: String {
        if let elevation = weatherReport.report.conditions?.elevationFt {
            return "\(elevation) ft"
        } else {
            return "Unknown"
        }
    }

    var tempC: String {
        if let temp = weatherReport.report.conditions?.tempC {
            return "\(temp) °C"
        } else {
            return "Unknown"
        }
    }

    var dewpointC: String {
        if let dew = weatherReport.report.conditions?.dewpointC {
            return "\(dew) °C"
        } else {
            return "Unknown"
        }
    }

    var pressureHg: String {
        if let pressure = weatherReport.report.conditions?.pressureHg {
            return "\(pressure) inHg"
        } else {
            return "Unknown"
        }
    }

    var pressureHpa: String {
        if let pressure = weatherReport.report.conditions?.pressureHpa {
            return "\(pressure) hPa"
        } else {
            return "Unknown"
        }
    }

    var densityAltitudeFt: String {
        if let density = weatherReport.report.conditions?.densityAltitudeFt {
            return "\(density) ft"
        } else {
            return "Unknown"
        }
    }

    var relativeHumidity: String {
        if let rh = weatherReport.report.conditions?.relativeHumidity {
            return "\(rh)%"
        } else {
            return "Unknown"
        }
    }
    var flightRules: String { weatherReport.report.conditions?.flightRules ?? "Unknown" }
    
    var cloudLayers: String {
        let layers = weatherReport.report.conditions?.cloudLayers ?? []
        return layers.map {
            "\($0.coverage?.uppercased() ?? "Unknown") at \($0.altitudeFt ?? 0.0) ft"
        }.joined(separator: ", ")
    }

    var cloudLayersV2: String {
        let layers = weatherReport.report.conditions?.cloudLayersV2 ?? []
        return layers.map {
            "\($0.coverage?.uppercased() ?? "Unknown") at \($0.altitudeFt ?? 0.0) ft"
        }.joined(separator: ", ")
    }
    
    var weather: String { weatherReport.report.conditions?.weather?.joined(separator: ", ") ?? "N/A" }
    
    var visibility: String { "\(String(weatherReport.report.conditions?.visibility?.distanceSm ?? 0)) SM"}
    
    var wind: String {
        let w = weatherReport.report.conditions?.wind
        let speed = w?.speedKts != nil ? "\(w?.speedKts ?? 0.0) kt" : "N/A"
        let direction = w?.direction != nil ? "\(w?.direction ?? 0)°" : "N/A"
        return "\(direction) at \(speed)"
    }
    
    var remarks: String {
        if let temp = weatherReport.report.conditions?.remarks?.temperature {
            return "Temp: \(temp) °C"
        }
        return "N/A"
    }
    
    var longestRunway: String { "\(weatherReport.report.conditions?.longestRunway ?? 0) ft" }
    
    // MARK: - Forecast

    var forecastText: String { weatherReport.report.forecast?.text ?? "Unknown" }
    var forecastDateIssued: String { formatDate(weatherReport.report.forecast?.dateIssued ?? "Unknown") }
    var forecastPeriod: String {
        "\(formatDate(weatherReport.report.forecast?.period?.dateStart ?? "Unknown")) - \(formatDate(weatherReport.report.forecast?.period?.dateEnd ?? "Unknown"))"
    }
    var forecastElevationFt: String { "\(weatherReport.report.forecast?.elevationFt ?? 0.0) ft" }
    
    var forecastConditions: String {
        guard let conditions = weatherReport.report.forecast?.conditions else { return "Unknown" }
        return conditions.map { condition in
            var parts: [String] = []
            if let text = condition.text {
                parts.append("\nCondition: \(text)")
            }
            if let date = condition.dateIssued {
                parts.append("Date: \(formatDate(date))")
            }
            if let humidity = condition.relativeHumidity {
                parts.append("Humidity: \(humidity)%")
            }
            if let wind = condition.wind ?? nil {
                parts.append("Wind: \(wind.speedKts ?? 0) kt at \(wind.direction ?? 0)°")
            }
            if let visibility = condition.visibility {
                parts.append("Visibility: \(visibility.distanceSm ?? 0))")
            }
            return parts.joined(separator: "\n")
        }.joined(separator: "\n\n")
    }
}
