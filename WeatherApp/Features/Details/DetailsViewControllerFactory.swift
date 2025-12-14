//
//  DetailsViewControllerFactory.swift
//  WeatherApp
//
//  Created by Aleksandra Kustra on 10/12/2025.
//

protocol DetailsViewControllerFactoryProtocol {
    func build(airport: String, weatherReportEntity: WeatherReportModel) -> DetailsViewController
}

final class DetailsViewControllerFactory: DetailsViewControllerFactoryProtocol {
    func build(airport: String, weatherReportEntity: WeatherReportModel) -> DetailsViewController {
        let viewModel = DetailsViewModel(airport: airport, weatherReportEntity: weatherReportEntity)
        
        let appearanceManager = DetailsAppearanceManager()
        let layoutManager = DetailsLayoutManager()
        
        let viewFactory = DetailsViewFactory(
            appearanceManager: appearanceManager,
            layoutManager: layoutManager
        )
        
        return DetailsViewController(
            viewFactory: viewFactory,
            viewModel: viewModel
        )
    }
}
