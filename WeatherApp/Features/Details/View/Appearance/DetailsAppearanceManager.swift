//
//  DetailsAppearanceManager.swift
//  WeatherApp
//
//  Created by Aleksandra Kustra on 10/12/2025.
//

import UIKit

final class DetailsAppearanceManager {}

extension DetailsAppearanceManager: DetailsAppearanceManaging {
    func decorate(view: DetailsViewInterface) {
        
        view.backgroundColor = .systemBackground
        
        view.contentStackView.axis = .vertical
        view.contentStackView.spacing = 12
        
        // MARK: - General
        view.airportLabel.font = Constants.titleFont
        view.airportLabel.textColor = .label
        view.airportLabel.numberOfLines = 0
        
        view.dateLabel.font = Constants.defaultFont
        view.dateLabel.textColor = .label
        view.dateLabel.numberOfLines = 0
        
        view.coordinatesLabel.font = Constants.defaultFont
        view.coordinatesLabel.textColor = .label
        view.coordinatesLabel.numberOfLines = 0
        
        view.displaySegmentedControl.selectedSegmentTintColor = .systemBlue
        view.displaySegmentedControl.backgroundColor = .systemGray6
        view.displaySegmentedControl.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
        view.displaySegmentedControl.setTitleTextAttributes([.foregroundColor: UIColor.systemBlue], for: .normal)
        
        // MARK: - Conditions
        view.conditionsStackView.axis = .vertical
        view.conditionsStackView.spacing = 4
        
        view.conditionsTitleLabel.font = Constants.titleFont
        view.conditionsTitleLabel.textColor = .label
        view.conditionsTitleLabel.numberOfLines = 0
        
        view.conditionsTextLabel.font = Constants.defaultFont
        view.conditionsTextLabel.textColor = .label
        view.conditionsTextLabel.numberOfLines = 0
        
        view.conditionsDateLabel.font = Constants.defaultFont
        view.conditionsDateLabel.textColor = .label
        view.conditionsDateLabel.numberOfLines = 0
        
        view.conditionsElevationFtLabel.font = Constants.defaultFont
        view.conditionsElevationFtLabel.textColor = .label
        view.conditionsElevationFtLabel.numberOfLines = 0
        
        view.temperatureLabel.font = Constants.defaultFont
        view.temperatureLabel.textColor = .label
        view.temperatureLabel.numberOfLines = 0
        
        view.dewpointLabel.font = Constants.defaultFont
        view.dewpointLabel.textColor = .label
        view.dewpointLabel.numberOfLines = 0
        
        view.pressureHgLabel.font = Constants.defaultFont
        view.pressureHgLabel.textColor = .label
        view.pressureHgLabel.numberOfLines = 0
        
        view.pressureHpaLabel.font = Constants.defaultFont
        view.pressureHpaLabel.textColor = .label
        view.pressureHpaLabel.numberOfLines = 0
        
        view.densityAltitudeFtLabel.font = Constants.defaultFont
        view.densityAltitudeFtLabel.textColor = .label
        view.densityAltitudeFtLabel.numberOfLines = 0
        
        view.relativeHumidityLabel.font = Constants.defaultFont
        view.relativeHumidityLabel.textColor = .label
        view.relativeHumidityLabel.numberOfLines = 0

        view.flightRulesLabel.font = Constants.defaultFont
        view.flightRulesLabel.textColor = .label
        view.flightRulesLabel.numberOfLines = 0
        
        view.cloudLayersLabel.font = Constants.defaultFont
        view.cloudLayersLabel.textColor = .label
        view.cloudLayersLabel.numberOfLines = 0
        
        view.weatherLabel.font = Constants.defaultFont
        view.weatherLabel.textColor = .label
        view.weatherLabel.numberOfLines = 0
        
        view.visibilityLabel.font = Constants.defaultFont
        view.visibilityLabel.textColor = .label
        view.visibilityLabel.numberOfLines = 0
        
        view.windLabel.font = Constants.defaultFont
        view.windLabel.textColor = .label
        view.windLabel.numberOfLines = 0
        
        view.longestRunwayLabel.font = Constants.defaultFont
        view.longestRunwayLabel.textColor = .label
        view.longestRunwayLabel.numberOfLines = 0
        
        // MARK: - Forecast
        view.forecastStackView.axis = .vertical
        view.forecastStackView.spacing = 4
        
        view.forecastTitleLabel.font = Constants.titleFont
        view.forecastTitleLabel.textColor = .label
        view.forecastTitleLabel.numberOfLines = 0
        
        view.forecastTextLabel.font = Constants.defaultFont
        view.forecastTextLabel.textColor = .label
        view.forecastTextLabel.numberOfLines = 0
        
        view.forecastDateIssuedLabel.font = Constants.defaultFont
        view.forecastDateIssuedLabel.textColor = .label
        view.forecastDateIssuedLabel.numberOfLines = 0
        
        view.forecastPeriodLabel.font = Constants.defaultFont
        view.forecastPeriodLabel.textColor = .label
        view.forecastPeriodLabel.numberOfLines = 0
        
        view.forecastElevationFtLabel.font = Constants.defaultFont
        view.forecastElevationFtLabel.textColor = .label
        view.forecastElevationFtLabel.numberOfLines = 0
        
        view.forecastConditionsLabel.font = Constants.defaultFont
        view.forecastConditionsLabel.textColor = .label
        view.forecastConditionsLabel.numberOfLines = 0
    }
    
    private struct Constants {
        static let defaultFont = UIFont.systemFont(ofSize: 16)
        static let titleFont = UIFont.boldSystemFont(ofSize: 18)
    }
}
