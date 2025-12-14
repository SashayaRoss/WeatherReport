//
//  ListAppearanceManager.swift
//  WeatherApp
//
//  Created by Aleksandra Kustra on 10/12/2025.
//

import UIKit

final class ListAppearanceManager: ListAppearanceManaging {
    func decorate(view: ListViewInterface) {
        view.backgroundColor = .systemBackground
        
        view.tableView.backgroundColor = .clear
        view.tableView.separatorColor = .clear
        view.tableView.showsVerticalScrollIndicator = false
        
        view.activityIndicator.color = .gray
    }
}
