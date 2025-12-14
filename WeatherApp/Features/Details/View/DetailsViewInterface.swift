//
//  DetailsViewInterface.swift
//  WeatherApp
//
//  Created by Aleksandra Kustra on 10/12/2025.
//

import UIKit

protocol DetailsViewInterface: UIView {
    var displaySegmentedControl: UISegmentedControl { get }
    var scrollView: UIScrollView { get }
    var contentStackView: UIStackView { get }

    // MARK: - General Info
    var airportLabel: UILabel { get }
    var dateLabel: UILabel { get }
    var coordinatesLabel: UILabel { get }

    // MARK: - Conditions
    var conditionsStackView: UIStackView { get }
    var conditionsTitleLabel: UILabel { get }
    var conditionsTextLabel: UILabel { get }
    var conditionsDateLabel: UILabel { get }
    var conditionsElevationFtLabel: UILabel  { get }
    var temperatureLabel: UILabel { get }
    var dewpointLabel: UILabel { get }
    var pressureHgLabel: UILabel { get }
    var pressureHpaLabel: UILabel { get }
    var densityAltitudeFtLabel: UILabel { get }
    var relativeHumidityLabel: UILabel { get }
    var flightRulesLabel: UILabel { get }
    var cloudLayersLabel: UILabel { get }
    var weatherLabel: UILabel { get }
    var visibilityLabel: UILabel { get }
    var windLabel: UILabel { get }
    var longestRunwayLabel: UILabel { get }
    
    // MARK: - Forecast
    var forecastStackView: UIStackView { get }
    var forecastTitleLabel: UILabel { get }
    var forecastTextLabel: UILabel { get }
    var forecastDateIssuedLabel: UILabel { get }
    var forecastPeriodLabel: UILabel  { get }
    var forecastElevationFtLabel: UILabel { get }
    var forecastConditionsLabel: UILabel { get }
}
