//
//  WeatherReportCacheMock.swift
//  WeatherApp
//
//  Created by Aleksandra Kustra on 14/12/2025.
//

import Foundation
@testable import WeatherApp

final class WeatherReportCacheMock: WeatherReportCacheProtocol {
    var cache: [String: WeatherReportModel] = [:]
    var getCalledWith: String?
    var setCalledWith: (String, WeatherReportModel)?

    func get(for airport: String) -> WeatherReportModel? {
        getCalledWith = airport
        return cache[airport]
    }

    func set(_ report: WeatherReportModel, for airport: String) {
        setCalledWith = (airport, report)
        cache[airport] = report
    }

    func clear() {
        cache.removeAll()
    }
}
