//
//  WeatherReportRepository.swift
//  WeatherApp
//
//  Created by Aleksandra Kustra on 13/12/2025.
//

final class WeatherReportService {
    private let networkRepository: NetworkWeatherReportLoading
    private let cache: WeatherReportCacheProtocol
    
    init(networkRepository: NetworkWeatherReportLoading, cache: WeatherReportCacheProtocol) {
        self.networkRepository = networkRepository
        self.cache = cache
    }
}

extension WeatherReportService: WeatherReportLoading {
    func getWeatherReport(for airport: String) async throws -> WeatherReportModel {
        do {
            let report = try await networkRepository.fetchReport(for: airport)
            cache.set(report, for: airport)
            return report
        } catch {
            if let cached = cache.get(for: airport) {
                return cached
            }
            throw error
        }
    }
    
    func getReports(for airports: [String]) async throws -> [String: WeatherReportModel] {
        var reports: [String: WeatherReportModel] = [:]

        try await withThrowingTaskGroup(of: (String, WeatherReportModel?).self) { group in
            for airport in airports {
                group.addTask {
                    do {
                        let report = try await self.getWeatherReport(for: airport)
                        return (airport, report)
                    } catch {
                        return (airport, nil)
                    }
                }
            }

            for try await (airport, report) in group {
                if let report {
                    reports[airport] = report
                }
            }
        }
        return reports
    }

    func clearCache() {
        cache.clear()
    }
}
