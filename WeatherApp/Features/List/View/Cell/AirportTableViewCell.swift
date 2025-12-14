//
//  AirportTableViewCell.swift
//  WeatherApp
//
//  Created by Aleksandra Kustra on 10/12/2025.
//

import UIKit

final class AirportTableViewCell: UITableViewCell {
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = Constants.stackViewSpacing
        stackView.alignment = .center
        stackView.backgroundColor = .systemBackground
        stackView.layer.cornerRadius = Constants.stackViewCornerRadius
        stackView.layer.shadowColor = Constants.stackViewShadowColor
        stackView.layer.shadowOpacity = Constants.stackViewShadowOpacity
        stackView.layer.shadowOffset = Constants.stackViewShadowOffset
        stackView.layer.shadowRadius = Constants.stackViewShadowRadius
        return stackView
    }()

    private let weatherIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .systemBlue
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.defaultFont
        label.textColor = .label
        return label
    }()
    
    private var id: Int?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpConstraints()
        setupAppearance()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setUpConstraints() {
        super.layoutSubviews()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        weatherIconImageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(stackView)
        stackView.addArrangedSubview(weatherIconImageView)
        stackView.addArrangedSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.padding),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.padding),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.padding),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constants.padding),
            
            weatherIconImageView.widthAnchor.constraint(equalToConstant: Constants.iconSize),
            weatherIconImageView.heightAnchor.constraint(equalToConstant: Constants.iconSize)
        ])
    }
    
    private func setupAppearance() {
        backgroundColor = .clear
        selectionStyle = .none
    }
    
    func configure(with viewModel: WeatherReportListCellViewModel) {
        titleLabel.text = viewModel.airportName
        weatherIconImageView.image = UIImage(systemName: viewModel.weatherIconName)
    }

    enum Constants {
        static let stackViewSpacing: Double = 12.0
        static let stackViewBackgroundColor: UIColor = .systemBackground
        static let stackViewShadowColor: CGColor = UIColor.black.cgColor
        static let stackViewShadowOpacity: Float = 0.05
        static let stackViewShadowOffset: CGSize = CGSize(width: 0, height: 2)
        static let stackViewCornerRadius: Double = 10.0
        static let stackViewShadowRadius: Double = 4.0
        static let defaultFont = UIFont.systemFont(ofSize: 18)
        static let padding: Double = 10.0
        static let iconSize: Double = 40.0
    }
}
