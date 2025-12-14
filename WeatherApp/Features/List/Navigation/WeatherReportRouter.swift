//
//  WeatherReportRouter.swift
//  WeatherApp
//
//  Created by Aleksandra Kustra on 14/12/2025.
//

import UIKit

final class WeatherReportRouter: WeatherReportRouting {
    private weak var navigationController: UINavigationController?
    private let detailsFactory: DetailsViewControllerFactoryProtocol
    
    init(navigationController: UINavigationController?, detailsFactory: DetailsViewControllerFactoryProtocol) {
        self.navigationController = navigationController
        self.detailsFactory = detailsFactory
    }
    
    func showDetails(for airport: String, entityID: WeatherReportModel) {
        guard let navigationController else { return }
        let viewController = detailsFactory.build(airport: airport, weatherReportEntity: entityID)
        navigationController.pushViewController(viewController, animated: true)
    }
}
