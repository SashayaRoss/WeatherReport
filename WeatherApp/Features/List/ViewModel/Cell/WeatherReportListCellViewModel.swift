//
//  ListCellViewModel.swift
//  WeatherApp
//
//  Created by Aleksandra Kustra on 10/12/2025.
//

import Foundation

final class WeatherReportListCellViewModel {
    let weatherIconName: String = "cloud.sun.fill"
    let airportName: String
    
    init(airportName: String) {
        self.airportName = airportName
    }
}
