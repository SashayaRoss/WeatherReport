//
//  DetailsView.swift
//  WeatherApp
//
//  Created by Aleksandra Kustra on 10/12/2025.
//

import UIKit

final class DetailsView: UIView, DetailsViewInterface {
    let displaySegmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: ["Conditions", "Forecast"])
        segmentedControl.selectedSegmentIndex = 0
        return segmentedControl
    }()

    let scrollView = UIScrollView()
    let contentStackView = UIStackView()

    // MARK: - General Info
    let airportLabel = UILabel()
    let dateLabel = UILabel()
    let coordinatesLabel = UILabel()

    // MARK: - Conditions
    let conditionsStackView = UIStackView()
    let conditionsTitleLabel = UILabel()
    let conditionsTextLabel = UILabel()
    let conditionsDateLabel = UILabel()
    let conditionsElevationFtLabel = UILabel()
    let temperatureLabel = UILabel()
    let dewpointLabel = UILabel()
    let pressureHgLabel = UILabel()
    let pressureHpaLabel = UILabel()
    let densityAltitudeFtLabel = UILabel()
    let relativeHumidityLabel = UILabel()
    let flightRulesLabel = UILabel()
    let cloudLayersLabel = UILabel()
    let weatherLabel = UILabel()
    let visibilityLabel = UILabel()
    let windLabel = UILabel()
    let longestRunwayLabel = UILabel()
    
    // MARK: - Forecast
    let forecastStackView = UIStackView()
    let forecastTitleLabel = UILabel()
    let forecastTextLabel = UILabel()
    let forecastDateIssuedLabel = UILabel()
    let forecastPeriodLabel = UILabel()
    let forecastElevationFtLabel = UILabel()
    let forecastConditionsLabel = UILabel()
}
