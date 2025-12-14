//
//  NetworkWeatherReportRepository.swift
//  WeatherApp
//
//  Created by Aleksandra Kustra on 10/12/2025.
//

import Foundation

final class NetworkWeatherReportRepository {
    enum Error: Swift.Error {
        case networkServiceUnavailable
        case invalidResponse(error: Swift.Error)
        case invalidData(error: Swift.Error)
    }
    
    private let networkService: NetworkServiceProviding?
    private let endpoint: AirportProviding

    init(
        networkService: NetworkServiceProviding?,
        endpoint: AirportProviding
    ) {
        self.networkService = networkService
        self.endpoint = endpoint
    }
}

extension NetworkWeatherReportRepository: NetworkWeatherReportLoading {
    func fetchReport(for airportIdentifier: String) async throws -> WeatherReportModel {
        guard let network = networkService else {
            throw Error.networkServiceUnavailable
        }

        let endpoint = endpoint.getAirportPath(for: airportIdentifier)

        do {
            let data = try await network.requestData(with: endpoint)
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return try decoder.decode(WeatherReportModel.self, from: data)
        } catch let decodingError as DecodingError {
            throw Error.invalidData(error: decodingError)
        } catch let error as NetworkService.Error {
            switch error {
            case .invalidResponse, .invalidUrl, .invalidData:
                throw Error.invalidResponse(error: error)
            }
        } catch {
            throw Error.networkServiceUnavailable
        }
    }
}
