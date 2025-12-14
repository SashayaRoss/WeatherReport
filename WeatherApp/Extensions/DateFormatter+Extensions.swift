//
//  DateFormatter+Extensions.swift
//  WeatherApp
//
//  Created by Aleksandra Kustra on 12/12/2025.
//

import Foundation

extension DateFormatter {
    static let displayDateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .long
        return dateFormatter
    }()
}
