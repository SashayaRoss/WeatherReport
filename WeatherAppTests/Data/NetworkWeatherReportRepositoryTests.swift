//
//  NetworkWeatherReportRepositoryTests.swift
//  WeatherApp
//
//  Created by Aleksandra Kustra on 14/12/2025.
//

import XCTest
@testable import WeatherApp

final class NetworkWeatherReportRepositoryTests: XCTestCase {
    var networkMock: NetworkServiceMock!
    var endpointMock: AirportEndpointMock!
    var sut: NetworkWeatherReportRepository!

    override func setUp() {
        super.setUp()
        networkMock = NetworkServiceMock()
        endpointMock = AirportEndpointMock()
        
        sut = NetworkWeatherReportRepository(
            networkService: networkMock,
            endpoint: endpointMock
        )
    }

    override func tearDown() {
        sut = nil
        networkMock = nil
        endpointMock = nil
        super.tearDown()
    }

    func testFetchReportSuccess() async throws {
        let json = """
        {
          "report": {
            "conditions": {
              "text": "Conditions example",
              "ident": "KPWM",
              "tempC": 20.0,
            },
            "forecast": {
              "text": "Forecast example",
            }
          }
        }
        """.data(using: .utf8)!
        
        networkMock.data = json

        let report = try await sut.fetchReport(for: "KPWM")

        await MainActor.run {
            XCTAssertEqual(report.report.conditions?.text, "Conditions example")
            XCTAssertEqual(report.report.conditions?.ident, "KPWM")
            XCTAssertEqual(report.report.conditions?.tempC, 20)
            XCTAssertEqual(report.report.forecast?.text, "Forecast example")
        }
    }

    func testFetchReportNetworkServiceUnavailable() async throws {
        sut = await NetworkWeatherReportRepository(networkService: nil, endpoint: endpointMock)

        do {
            _ = try await sut.fetchReport(for: "KPWM")
            XCTFail("Request should fail")
        } catch let error as NetworkWeatherReportRepository.Error {
            switch error {
            case .networkServiceUnavailable:
                break
            default:
                XCTFail("Wrong error type: \(error)")
            }
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
    }

    func testFetchReportInvalidResponse() async throws {
        networkMock.error = NetworkService.Error.invalidResponse

        do {
            _ = try await sut.fetchReport(for: "KPWM")
            XCTFail("Request should fail")
        } catch let error as NetworkWeatherReportRepository.Error {
            switch error {
            case .invalidResponse:
                break
            default:
                XCTFail("Wrong error type: \(error)")
            }
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
    }

    func testFetchReportInvalidData() async throws {
        networkMock.data = """
        { "wrong_field": 123 }
        """.data(using: .utf8)!
        await sut = NetworkWeatherReportRepository(networkService: networkMock, endpoint: endpointMock)

        do {
            _ = try await sut.fetchReport(for: "KPWM")
            XCTFail("Request should fail")
        } catch let error as NetworkWeatherReportRepository.Error {
            switch error {
            case .invalidData:
                break
            default:
                XCTFail("Wrong error type: \(error)")
            }
        }
    }
}
