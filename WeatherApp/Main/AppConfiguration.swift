//
//  AppConfiguration.swift
//  WeatherApp
//
//  Created by Aleksandra Kustra on 10/12/2025.
//

import Foundation

struct AppConfiguration {
    lazy var baseURL: String = {
        "https://qa.foreflight.com/"
    }()
    
    lazy var HTTPHeaderField: [String:String] = {
        ["ff-coding-exercise": "1"]
    }()
}
