//
//  WeatherReportServiceTests.swift
//  WeatherApp
//
//  Created by Aleksandra Kustra on 14/12/2025.
//

import XCTest
@testable import WeatherApp

final class WeatherReportServiceTests: XCTestCase {
    var networkMock: NetworkWeatherReportRepositoryMock!
    var cacheMock: WeatherReportCacheMock!
    var sut: WeatherReportService!
    
    override func setUp() {
        super.setUp()
        networkMock = NetworkWeatherReportRepositoryMock()
        cacheMock = WeatherReportCacheMock()
        sut = WeatherReportService(networkRepository: networkMock, cache: cacheMock)
    }
    
    override func tearDown() {
        networkMock = nil
        cacheMock = nil
        sut = nil
        super.tearDown()
    }
    
    func testGetWeatherReportSuccessStoresInCache() async throws {
        let report = WeatherReportModel(
            report: Report(
                conditions: Conditions(
                    text: "Conditions text",
                    ident: "KPWM",
                    dateIssued: "2025-12-14",
                    lat: nil,
                    lon: nil,
                    elevationFt: nil,
                    tempC: 5,
                    dewpointC: nil,
                    pressureHg: nil,
                    pressureHpa: nil,
                    reportedAsHpa: nil,
                    densityAltitudeFt: nil,
                    relativeHumidity: nil,
                    flightRules: nil,
                    cloudLayers: nil,
                    cloudLayersV2: nil,
                    weather: nil,
                    visibility: nil,
                    wind: nil,
                    remarks: nil,
                    longestRunway: 10000),
            forecast: nil,
            windsAloft: nil,
            mos: nil
        ))
        networkMock.reportToReturn = report

        let result = try await sut.getWeatherReport(for: "KPWM")

        await MainActor.run {
            XCTAssertEqual(result.report.conditions?.text, "Conditions text")
            XCTAssertEqual(result.report.conditions?.tempC, 5)
            XCTAssertEqual(cacheMock.setCalledWith?.0, "KPWM")
            XCTAssertEqual(cacheMock.setCalledWith?.1.report.conditions?.dateIssued, "2025-12-14")
            XCTAssertEqual(cacheMock.setCalledWith?.1.report.conditions?.text, "Conditions text")
            XCTAssertEqual(cacheMock.setCalledWith?.1.report.conditions?.longestRunway, 10000)
        }
    }

    func testGetWeatherReportNetworkFailsReturnsCached() async throws {
        let cachedReport = WeatherReportModel(
            report: Report(
                conditions: Conditions(
                    text: "Conditions text 2",
                    ident: "KPWM",
                    dateIssued: nil,
                    lat: nil,
                    lon: nil,
                    elevationFt: nil,
                    tempC: 3,
                    dewpointC: nil,
                    pressureHg: nil,
                    pressureHpa: nil,
                    reportedAsHpa: nil,
                    densityAltitudeFt: nil,
                    relativeHumidity: nil,
                    flightRules: nil,
                    cloudLayers: nil,
                    cloudLayersV2: nil,
                    weather: nil,
                    visibility: nil,
                    wind: nil,
                    remarks: nil,
                    longestRunway: nil),
            forecast: nil,
            windsAloft: nil,
            mos: nil
        ))
        cacheMock.cache["KPWM"] = cachedReport
        networkMock.shouldThrow = true

        let result = try await sut.getWeatherReport(for: "KPWM")

        await MainActor.run {
            XCTAssertEqual(result.report.conditions?.text, "Conditions text 2")
            XCTAssertEqual(result.report.conditions?.tempC, 3)
        }
    }

    func testGetWeatherReportNetworkFailsCacheEmptyThrows() async {
        networkMock.shouldThrow = true

        do {
            _ = try await sut.getWeatherReport(for: "KPWM")
            XCTFail("Expected error to be thrown")
        } catch {}
    }

    func testGetReportsMultipleAirports() async throws {
        let report1 = WeatherReportModel(
            report: Report(
                conditions: Conditions(
                    text: "Conditions text for report 1",
                    ident: "KPWM",
                    dateIssued: nil,
                    lat: nil,
                    lon: nil,
                    elevationFt: nil,
                    tempC: nil,
                    dewpointC: nil,
                    pressureHg: nil,
                    pressureHpa: nil,
                    reportedAsHpa: nil,
                    densityAltitudeFt: nil,
                    relativeHumidity: nil,
                    flightRules: nil,
                    cloudLayers: nil,
                    cloudLayersV2: nil,
                    weather: nil,
                    visibility: nil,
                    wind: nil,
                    remarks: nil,
                    longestRunway: nil),
            forecast: nil,
            windsAloft: nil,
            mos: nil
        ))
        let report2 = WeatherReportModel(
            report: Report(
                conditions: Conditions(
                    text: "Conditions text for report 2",
                    ident: "KAUS",
                    dateIssued: nil,
                    lat: nil,
                    lon: nil,
                    elevationFt: nil,
                    tempC: nil,
                    dewpointC: nil,
                    pressureHg: nil,
                    pressureHpa: nil,
                    reportedAsHpa: nil,
                    densityAltitudeFt: nil,
                    relativeHumidity: nil,
                    flightRules: nil,
                    cloudLayers: nil,
                    cloudLayersV2: nil,
                    weather: nil,
                    visibility: nil,
                    wind: nil,
                    remarks: nil,
                    longestRunway: nil),
            forecast: nil,
            windsAloft: nil,
            mos: nil
        ))

        networkMock.reports = [
            "KPWM": report1,
            "KAUS": report2
        ]

        let results = try await sut.getReports(for: ["KPWM", "KAUS"])

        await MainActor.run {
            XCTAssertEqual(results["KPWM"]?.report.conditions?.text, "Conditions text for report 1")
            XCTAssertEqual(results["KAUS"]?.report.conditions?.text, "Conditions text for report 2")
        }
    }

    func testClearCache() {
        cacheMock.cache["KPWM"] = WeatherReportModel(report: Report(conditions: nil, forecast: nil, windsAloft: nil, mos: nil))

        sut.clearCache()
        XCTAssertTrue(cacheMock.cache.isEmpty)
    }
}
