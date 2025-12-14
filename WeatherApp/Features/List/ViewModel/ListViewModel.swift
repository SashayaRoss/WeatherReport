//
//  ListViewModel.swift
//  WeatherApp
//
//  Created by Aleksandra Kustra on 10/12/2025.
//

import UIKit

@MainActor
final class ListViewModel {
    private let airportRepository: PersistenceAirportLoading
    private let weatherReportRepository: WeatherReportLoading
    private let router: WeatherReportRouting
    private var updater: WeatherUpdaterProtocol?
    
    private(set) var airports: [String] = []
    private(set) var airportWeatherReports: [String: WeatherReportModel] = [:]
    private(set) var state: ListViewState = .finishedLoading {
        didSet { onStateChange?(state) }
    }
    var onStateChange: ((ListViewState) -> Void)?

    init(
        airportRepository: PersistenceAirportLoading,
        weatherReportRepository: WeatherReportLoading,
        router: WeatherReportRouting,
        updater: WeatherUpdaterProtocol? = nil
    ) {
        self.airportRepository = airportRepository
        self.weatherReportRepository = weatherReportRepository
        self.router = router
        self.updater = updater
    }
    
    // MARK: - Setup
    
    func loadPersistedAirports() async {
        do {
            airports = try await airportRepository.loadAirports()
        } catch {
            state = .error(error: Error.failedToLoad)
            airports = []
        }
    }
    
    func loadInitialWeatherReports() async {
        guard !airports.isEmpty else {
            state = .finishedLoading
            return
        }
        
        state = .loading
        do {
            airportWeatherReports = try await weatherReportRepository.getReports(for: airports)
            state = .finishedLoading
        } catch {
            state = .error(error: error)
        }
    }
    
    // MARK: - Autoupdate
    
    func startAutoUpdate(interval: TimeInterval = 10) {
        updater = WeatherUpdater(interval: interval) { [weak self] in
            guard let self = self else { return }
            await self.refreshWeatherReports()
        }
        updater?.start()
    }

    func stopAutoUpdate() {
        updater?.stop()
        updater = nil
    }
    
    private func refreshWeatherReports() async {
        do {
            let reports = try await weatherReportRepository.getReports(for: airports)
            airportWeatherReports = reports
        } catch {
            state = .error(error: error)
        }
    }
    
    // MARK: - Manage data

    func addAirport(_ airportIdentification: String) async {
        let airport = airportIdentification
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .lowercased()
        
        guard !airport.isEmpty else {
            state = .error(error: Error.invalidAirport)
            return
        }
        
        guard !airports.contains(airport) else {
            state = .error(error: Error.duplicateAirport)
            return
        }
        
        state = .loading
        do {
            let report = try await weatherReportRepository.getWeatherReport(for: airport)
            try await airportRepository.addAirport(airport)
            airports.append(airport)
            airportWeatherReports[airport] = report
            router.showDetails(for: airport, entityID: report)
            state = .finishedLoading
        } catch is CancellationError {
            state = .finishedLoading
        } catch {
            state = .error(error: error)
        }
    }
    
    func clearCache() async{
        state = .loading
        weatherReportRepository.clearCache()
        do {
            try await airportRepository.clearCache()
            airportWeatherReports.removeAll()
            state = .finishedLoading
        } catch {
            state = .error(error: error)
        }
    }

    // MARK: - Navigation

    func showDetails(at index: Int) {
        guard
            airports.indices.contains(index),
            let report = airportWeatherReports[airports[index]]
        else { return }
        router.showDetails(for: airports[index], entityID: report)
    }
}

extension ListViewModel {
    enum Error: LocalizedError {
        case duplicateAirport
        case invalidAirport
        case failedToLoad

        var errorDescription: String? {
            switch self {
            case .duplicateAirport:
                return "This airport has already been added."
            case .invalidAirport:
                return "Please enter a valid airport identifier."
            case .failedToLoad:
                return "Failed to load airports"
            }
        }
    }
}
