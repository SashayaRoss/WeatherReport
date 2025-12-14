//
//  WeatherReportListViewControllerFactory.swift
//  WeatherApp
//
//  Created by Aleksandra Kustra on 10/12/2025.
//

import UIKit

final class ListViewControllerFactory {
    private weak var navigationController: UINavigationController?
    private let networkService: NetworkServiceProviding?
    private let detailsFactory: DetailsViewControllerFactoryProtocol
    private let cellViewModelFactory: (_ weatherReport: String) -> WeatherReportListCellViewModel
    
    init(
        navigationController: UINavigationController?,
        networkService: NetworkServiceProviding?,
        detailsFactory: DetailsViewControllerFactoryProtocol,
        cellViewModelFactory: @escaping (_ weatherReport: String) -> WeatherReportListCellViewModel
    ) {
        self.navigationController = navigationController
        self.networkService = networkService
        self.detailsFactory = detailsFactory
        self.cellViewModelFactory = cellViewModelFactory
    }

    func build() -> ListViewController {
        let airportRepository = PersistenceAirportRepository(container: PersistenceController.shared.container)
        let endpoint = WeatherReportEndpoint()
        let networkRepository = NetworkWeatherReportRepository(
            networkService: networkService,
            endpoint: endpoint
        )

        let cache = WeatherReportCache()
        
        let repository = WeatherReportService(
            networkRepository: networkRepository,
            cache: cache
        )
        
        let router = WeatherReportRouter(
            navigationController: navigationController,
            detailsFactory: detailsFactory
        )

        let viewModel = ListViewModel(
            airportRepository: airportRepository,
            weatherReportRepository: repository,
            router: router
        )
        
        let appearanceManager = ListAppearanceManager()
        let layoutManager = ListLayoutManager()

        let viewFactory = ListViewFactory(
            appearanceManager: appearanceManager,
            layoutManager: layoutManager
        )
        
        let viewController = ListViewController(
            viewModel: viewModel,
            viewFactory: viewFactory,
            cellViewModelFactory: cellViewModelFactory
        )
        
        return viewController
    }
}
