//
//  PersistenceAirportRepositoryTests.swift
//  WeatherApp
//
//  Created by Aleksandra Kustra on 14/12/2025.
//

import XCTest
import CoreData
@testable import WeatherApp

final class PersistenceAirportRepositoryTests: XCTestCase {
    var sut: PersistenceAirportRepository!
    var container: NSPersistentContainer!
    
    override func setUp() async throws {
        try await super.setUp()

        container = NSPersistentContainer(name: "WeatherModel")
        let description = NSPersistentStoreDescription()
        description.type = NSInMemoryStoreType
        container.persistentStoreDescriptions = [description]

        let expectation = XCTestExpectation(description: "Load persistent stores")
        container.loadPersistentStores { _, error in
            XCTAssertNil(error)
            expectation.fulfill()
        }

        await MainActor.run {
            sut = PersistenceAirportRepository(
                defaultAirports: ["KPWM", "KAUS"],
                container: container
            )
        }
    }

    override func tearDown() async throws {
        sut = nil
        container = nil
        try await super.tearDown()
    }

    func testLoadAirports_EmptyContextInsertsDefaults() async throws {
        let airports = try await sut.loadAirports()
        XCTAssertEqual(airports.sorted(), ["KAUS", "KPWM"])
    }

    func testAddAirportValidAirportSaves() async throws {
        try await sut.addAirport("KAUS")
        let airports = try await sut.loadAirports()
        XCTAssertTrue(airports.contains("kaus"))
    }

    func testAddAirportEmptyAirportDoesNothing() async throws {
        try await sut.addAirport("")
        let airports = try await sut.loadAirports()
        XCTAssertEqual(airports.sorted(), ["KAUS", "KPWM"])
    }
}
