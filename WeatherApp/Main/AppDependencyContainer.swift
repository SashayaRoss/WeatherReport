//
//  AppDependencyContainer.swift
//  WeatherApp
//
//  Created by Aleksandra Kustra on 10/12/2025.
//

import UIKit

final class AppDependencyContainer {
    lazy var appConfiguration = AppConfiguration()
    lazy var navigationController: UINavigationController = {
        UINavigationController()
    }()

    private func makeNetworkService() -> NetworkService {
        guard let url = URL(string: appConfiguration.baseURL) else {
            fatalError("Invalid base URL")
        }
        let configuration = ApiDataNetworkConfig(
            baseURL: url,
            headers: appConfiguration.HTTPHeaderField
        )
        return NetworkService(config: configuration)
    }

    func makeListViewController() -> ListViewController {
        let networkService = makeNetworkService()
        let cellViewModelFactory = { (airportName: String) in
            return self.makeListCellViewModel(
                airportName: airportName
            )
        }
        
        let detailsFactory = DetailsViewControllerFactory()

        let viewControllerFactory = ListViewControllerFactory(
            navigationController: navigationController,
            networkService: networkService,
            detailsFactory: detailsFactory,
            cellViewModelFactory: cellViewModelFactory
        )
        return viewControllerFactory.build()
    }
    
    private func makeListCellViewModel(airportName: String) -> WeatherReportListCellViewModel {
        WeatherReportListCellViewModel(airportName: airportName)
    }
}

