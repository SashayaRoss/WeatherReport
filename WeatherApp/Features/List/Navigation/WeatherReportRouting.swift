//
//  WeatherReportRouting.swift
//  WeatherApp
//
//  Created by Aleksandra Kustra on 12/12/2025.
//

import Foundation

protocol WeatherReportRouting {
    func showDetails(for airport: String, entityID: WeatherReportModel)
}
