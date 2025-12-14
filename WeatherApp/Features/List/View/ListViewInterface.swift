//
//  ListViewInterface.swift
//  WeatherApp
//
//  Created by Aleksandra Kustra on 10/12/2025.
//

import UIKit

protocol ListViewInterface: UIView {
    var tableView: UITableView { get }
    var activityIndicator: UIActivityIndicatorView { get }
}
