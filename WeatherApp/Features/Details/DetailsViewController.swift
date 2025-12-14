//
//  DetailsViewController.swift
//  WeatherApp
//
//  Created by Aleksandra Kustra on 10/12/2025.
//

import UIKit

final class DetailsViewController: UIViewController {
    private enum WeatherDisplayMode {
        case conditions
        case forecast
    }

    private let viewFactory: DetailsViewProducing
    private let viewModel: DetailsViewModelProtocol
    private var displayMode: WeatherDisplayMode = .conditions

    private lazy var detailsView = viewFactory.make()
    
    init(
        viewFactory: DetailsViewProducing,
        viewModel: DetailsViewModelProtocol
    ) {
        self.viewFactory = viewFactory
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
        setupNavigationItem()
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = detailsView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        detailsView.displaySegmentedControl.addTarget(self, action: #selector(segmentedChanged(_:)), for: .valueChanged)
    }
    
    private func setupNavigationItem() {
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.title = "Weather Details"
    }
    
    @objc private func segmentedChanged(_ sender: UISegmentedControl) {
        displayMode = sender.selectedSegmentIndex == 0 ? .conditions : .forecast
        updateView(for: displayMode)
    }
    
    private func configure() {
        // MARK: - General Info
        detailsView.airportLabel.text = "Airport: \(viewModel.station)"
        detailsView.dateLabel.text = "Date Issued: \(viewModel.issued)"
        detailsView.coordinatesLabel.text = "Lat: \(viewModel.latitude), Lon: \(viewModel.longitude)"

        // MARK: - Conditions
        detailsView.conditionsTitleLabel.text = "Conditions"
        detailsView.conditionsTextLabel.text = "Conditions text: \(viewModel.text)"
        detailsView.conditionsDateLabel.text = "Date issued: \(viewModel.dateIssued)"
        detailsView.temperatureLabel.text = "Temperature: \(viewModel.tempC)"
        detailsView.dewpointLabel.text = "Dewpoint: \(viewModel.dewpointC)"
        detailsView.pressureHgLabel.text = "Pressure: \(viewModel.pressureHg)"
        detailsView.pressureHpaLabel.text = "Pressure: \(viewModel.pressureHpa)"
        detailsView.densityAltitudeFtLabel.text = "Density altitude: \(viewModel.densityAltitudeFt)"
        detailsView.relativeHumidityLabel.text = "Relative humidity: \(viewModel.relativeHumidity)"
        detailsView.flightRulesLabel.text = "Flight Rules: \(viewModel.flightRules)"
        detailsView.cloudLayersLabel.text = "Cloud Layers: \(viewModel.cloudLayers)"
        detailsView.weatherLabel.text = "Weather: \(viewModel.weather)"
        detailsView.visibilityLabel.text = "Visibility: \(viewModel.visibility)"
        detailsView.windLabel.text = "Wind: \(viewModel.wind)"
        detailsView.longestRunwayLabel.text = "Longest Runway: \(viewModel.longestRunway)"
        
        // MARK: - Forecast
        detailsView.forecastTitleLabel.text = "Forecast"
        detailsView.forecastTextLabel.text = "Forecast text: \(viewModel.forecastText)"
        detailsView.forecastDateIssuedLabel.text = "Date issued: \(viewModel.forecastDateIssued)"
        detailsView.forecastPeriodLabel.text = "Period: \(viewModel.forecastPeriod)"
        detailsView.forecastElevationFtLabel.text = "Elevation: \(viewModel.forecastElevationFt)"
        detailsView.forecastConditionsLabel.text = "Conditions: \(viewModel.forecastConditions)"

        updateView(for: displayMode)
    }
    
    private func updateView(for mode: WeatherDisplayMode) {
        switch mode {
        case .conditions:
            detailsView.conditionsTitleLabel.isHidden = false
            detailsView.conditionsStackView.isHidden = false
            detailsView.forecastTitleLabel.isHidden = true
            detailsView.forecastStackView.isHidden = true
        case .forecast:
            detailsView.conditionsTitleLabel.isHidden = true
            detailsView.conditionsStackView.isHidden = true
            detailsView.forecastTitleLabel.isHidden = false
            detailsView.forecastStackView.isHidden = false
        }
    }
}
