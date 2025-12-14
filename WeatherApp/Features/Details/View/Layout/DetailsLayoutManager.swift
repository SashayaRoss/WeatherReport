//
//  DetailsLayoutManager.swift
//  WeatherApp
//
//  Created by Aleksandra Kustra on 10/12/2025.
//

import UIKit

final class DetailsLayoutManager {
    private func setupHierarchy(in view: DetailsViewInterface) {
        view.addSubview(view.airportLabel)
        view.addSubview(view.dateLabel)
        view.addSubview(view.coordinatesLabel)
        view.addSubview(view.displaySegmentedControl)
        view.addSubview(view.scrollView)
        view.scrollView.addSubview(view.contentStackView)
        
        view.conditionsStackView.addArrangedSubview(view.conditionsTitleLabel)
        view.conditionsStackView.addArrangedSubview(view.conditionsTextLabel)
        view.conditionsStackView.addArrangedSubview(view.conditionsDateLabel)
        view.conditionsStackView.addArrangedSubview(view.conditionsElevationFtLabel)
        view.conditionsStackView.addArrangedSubview(view.temperatureLabel)
        view.conditionsStackView.addArrangedSubview(view.dewpointLabel)
        view.conditionsStackView.addArrangedSubview(view.pressureHgLabel)
        view.conditionsStackView.addArrangedSubview(view.pressureHpaLabel)
        view.conditionsStackView.addArrangedSubview(view.densityAltitudeFtLabel)
        view.conditionsStackView.addArrangedSubview(view.relativeHumidityLabel)
        view.conditionsStackView.addArrangedSubview(view.flightRulesLabel)
        view.conditionsStackView.addArrangedSubview(view.cloudLayersLabel)
        view.conditionsStackView.addArrangedSubview(view.weatherLabel)
        view.conditionsStackView.addArrangedSubview(view.visibilityLabel)
        view.conditionsStackView.addArrangedSubview(view.windLabel)
        view.conditionsStackView.addArrangedSubview(view.longestRunwayLabel)
        view.contentStackView.addArrangedSubview(view.conditionsStackView)

        view.forecastStackView.addArrangedSubview(view.forecastTitleLabel)
        view.forecastStackView.addArrangedSubview(view.forecastTextLabel)
        view.forecastStackView.addArrangedSubview(view.forecastDateIssuedLabel)
        view.forecastStackView.addArrangedSubview(view.forecastPeriodLabel)
        view.forecastStackView.addArrangedSubview(view.forecastElevationFtLabel)
        view.forecastStackView.addArrangedSubview(view.forecastConditionsLabel)
        view.contentStackView.addArrangedSubview(view.forecastStackView)
    }
    
    private func setupConstraints(in view: DetailsViewInterface) {
        view.airportLabel.translatesAutoresizingMaskIntoConstraints = false
        view.dateLabel.translatesAutoresizingMaskIntoConstraints = false
        view.coordinatesLabel.translatesAutoresizingMaskIntoConstraints = false
        view.displaySegmentedControl.translatesAutoresizingMaskIntoConstraints = false
        view.contentStackView.translatesAutoresizingMaskIntoConstraints = false
        view.scrollView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            view.airportLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constants.padding),
            view.airportLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.padding),
            view.airportLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.padding),
            
            view.dateLabel.topAnchor.constraint(equalTo: view.airportLabel.bottomAnchor, constant: Constants.padding),
            view.dateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.padding),
            view.dateLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.padding),
            
            view.coordinatesLabel.topAnchor.constraint(equalTo: view.dateLabel.bottomAnchor, constant: Constants.padding),
            view.coordinatesLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.padding),
            view.coordinatesLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.padding),
            
            view.displaySegmentedControl.topAnchor.constraint(equalTo: view.coordinatesLabel.bottomAnchor, constant: Constants.verticalPadding),
            view.displaySegmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.padding),
            view.displaySegmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.padding),

            view.scrollView.topAnchor.constraint(equalTo: view.displaySegmentedControl.bottomAnchor, constant: Constants.padding),
            view.scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            view.scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            view.scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            view.contentStackView.topAnchor.constraint(equalTo: view.scrollView.topAnchor, constant: Constants.padding),
            view.contentStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.padding),
            view.contentStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.padding),
            view.contentStackView.bottomAnchor.constraint(equalTo: view.scrollView.bottomAnchor, constant: -Constants.padding),
            view.contentStackView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -Constants.padding * 2)
        ])
    }
    
    private struct Constants {
        static let padding: CGFloat = 10.0
        static let verticalPadding: CGFloat = 20.0
    }
}

extension DetailsLayoutManager: DetailsLayoutManaging {
    func layout(view: DetailsViewInterface) {
        setupHierarchy(in: view)
        setupConstraints(in: view)
    }
}
