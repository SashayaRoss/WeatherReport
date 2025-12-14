//
//  NetworkServiceTests.swift
//  WeatherApp
//
//  Created by Aleksandra Kustra on 14/12/2025.
//

import XCTest
@testable import WeatherApp

final class NetworkServiceTests: XCTestCase {
    private var networkSession: NetworkSessionMock!
    private var sut: NetworkService!
    
    override func setUp() {
        super.setUp()
        let networkSession = NetworkSessionMock()
        
        guard let baseUrl = URL(string: "www.google.com") else {
            XCTFail("URL not valid.")
            return
        }
        let networkConfig = NetworkConfigMock(
            baseURL: baseUrl,
            headers: ["Authorization": "Bearer token"]
        )
        
        self.networkSession = networkSession
            
        sut = NetworkService(
            session: networkSession,
            config: networkConfig
        )
    }
    
    override func tearDown() {
        networkSession = nil
        sut = nil
        super.tearDown()
    }
    
    func testRequestForValidData() async throws {
        let sut = try XCTUnwrap(self.sut)
        let networkSession = try XCTUnwrap(self.networkSession)

        guard let url = URL(string: "www.google.com") else {
            XCTFail("URL not valid.")
            return
        }
        let mockResponseCode = 200
        let mockHttpResponse = HTTPURLResponse(
            url: url,
            statusCode: mockResponseCode,
            httpVersion: nil,
            headerFields: nil
        )

        let expectedData = Data([0, 1])
        networkSession.data = expectedData
        networkSession.response = mockHttpResponse

        let data = try await sut.requestData(with: "/ENDPOINT")

        XCTAssertEqual(data, expectedData)
    }
    
    func testRequestResponseCode500() async throws {
        let sut = try XCTUnwrap(self.sut)
        let networkSession = try XCTUnwrap(self.networkSession)

        guard let url = URL(string: "www.google.com") else {
            XCTFail("URL not valid.")
            return
        }
        let mockResponseCode = 500
        let mockHttpResponse = HTTPURLResponse(
            url: url,
            statusCode: mockResponseCode,
            httpVersion: nil,
            headerFields: nil
        )

        networkSession.data = Data([0, 1])
        networkSession.response = mockHttpResponse

        do {
            _ = try await sut.requestData(with: "/ENDPOINT")
            XCTFail("Request should fail.")
        } catch let error as NetworkService.Error {
            switch error {
            case .invalidData(let error):
                if let error = error as? NetworkService.Error, case .invalidResponse = error {
                } else {
                    XCTFail("Wrong underlying error: \(error)")
                }
            default:
                XCTFail("Wrong error type: \(error)")
            }
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
    }
    
    func testRequestNoValidData() async throws {
        let sut = try XCTUnwrap(self.sut)

        do {
            _ = try await sut.requestData(with: "/ENDPOINT")
            XCTFail("Request should fail")
        } catch {
            XCTAssertNotNil(error)
        }
    }
    
    func testRequestSessionError() async throws {
        let sut = try XCTUnwrap(self.sut)
        let networkSession = try XCTUnwrap(self.networkSession)

        let sessionError = NSError(domain: "", code: 1)
        networkSession.error = sessionError

        do {
            _ = try await sut.requestData(with: "/ENDPOINT")
            XCTFail("Request should fail.")
        } catch let error as NetworkService.Error {
            switch error {
            case .invalidData(let underlyingError):
                XCTAssertEqual((underlyingError as NSError).code, sessionError.code)
            default:
                XCTFail("Wrong error type")
            }
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
    }
}
