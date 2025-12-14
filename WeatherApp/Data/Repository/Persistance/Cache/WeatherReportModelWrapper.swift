//
//  WeatherReportModelWrapper.swift
//  WeatherApp
//
//  Created by Aleksandra Kustra on 14/12/2025.
//

import Foundation

final class WeatherReportModelWrapper: NSObject {
    let report: WeatherReportModel
    init(_ report: WeatherReportModel) {
        self.report = report
    }
}
