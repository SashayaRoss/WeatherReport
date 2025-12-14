//
//  WeatherReportCache.swift
//  WeatherApp
//
//  Created by Aleksandra Kustra on 14/12/2025.
//

import Foundation

final class WeatherReportCache {
    private let cache = NSCache<NSString, WeatherReportModelWrapper>()
}

extension WeatherReportCache: WeatherReportCacheProtocol {
    func set(_ report: WeatherReportModel, for airportIdentifier: String) {
        let wrapper = WeatherReportModelWrapper(report)
        cache.setObject(wrapper, forKey: airportIdentifier as NSString)
    }
    
    func get(for airportIdentifier: String) -> WeatherReportModel? {
        return cache.object(forKey: airportIdentifier as NSString)?.report
    }
    
    func clear() {
        cache.removeAllObjects()
    }
}
