//
//  ListLayoutManager.swift
//  WeatherApp
//
//  Created by Aleksandra Kustra on 10/12/2025.
//

import UIKit

final class ListLayoutManager {
    private func setupHierarchy(in view: ListViewInterface) {
        view.addSubview(view.tableView)
        view.addSubview(view.activityIndicator)
    }
    
    private func setupConstraints(in view: ListViewInterface) {
        view.tableView.translatesAutoresizingMaskIntoConstraints = false
        view.activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            view.tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            view.tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Constants.padding),
            view.tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -Constants.padding),
            view.tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            view.activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            view.activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    enum Constants {
        static let padding = 10.0
    }
}

extension ListLayoutManager: ListLayoutManaging {
    func layout(view: ListViewInterface) {
        setupHierarchy(in: view)
        setupConstraints(in: view)
    }
}
