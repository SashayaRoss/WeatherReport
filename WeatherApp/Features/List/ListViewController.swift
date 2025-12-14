//
//  ListViewController.swift
//  WeatherApp
//
//  Created by Aleksandra Kustra on 09/12/2025.
//

import UIKit

final class ListViewController: UIViewController {
    private let viewModel: ListViewModel
    private let viewFactory: ListViewProducing
    private let cellViewModelFactory: (_ airportName: String) -> WeatherReportListCellViewModel
    private lazy var searchController = UISearchController(searchResultsController: nil)

    private lazy var listView = viewFactory.make()
    
    init(
        viewModel: ListViewModel,
        viewFactory: ListViewProducing,
        cellViewModelFactory:  @escaping (_ airportName: String) -> WeatherReportListCellViewModel
    ) {
        self.viewModel = viewModel
        self.viewFactory = viewFactory
        self.cellViewModelFactory = cellViewModelFactory
        super.init(nibName: nil, bundle: nil)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = listView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.onStateChange = { [weak self] state in
            guard let self = self else { return }
            Task { @MainActor in
                self.handleState()
            }
        }

        Task { [weak self] in
            guard let self = self else { return }
            await self.loadInitialAirports()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.startAutoUpdate()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        viewModel.stopAutoUpdate()
    }
    
    private func loadInitialAirports() async {
        await viewModel.loadPersistedAirports()
        await viewModel.loadInitialWeatherReports()
    }
    
    private func setup() {
        setupNavigation()
        setupTableView()
        setupSearch()
    }
    
    private func setupNavigation() {
        navigationItem.title = "Weather report list"
        navigationItem.largeTitleDisplayMode = .always
        
        let clearCacheButton = UIBarButtonItem(
            image: UIImage(systemName: "trash"),
            style: .plain,
            target: self,
            action: #selector(clearCacheTapped)
        )
        clearCacheButton.tintColor = .systemBlue
        navigationItem.rightBarButtonItem = clearCacheButton
    }
    
    @objc private func clearCacheTapped() {
        Task { [weak self] in
            guard let self = self else { return }
            await self.viewModel.clearCache()
            let alert = UIAlertController(
                title: "Cache Cleared",
                message: "All cached weather reports and airports have been removed.",
                preferredStyle: .alert
            )
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(alert, animated: true)
            await self.loadInitialAirports()
        }
    }

    private func setupSearch() {
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Enter airport code (example: KPWM)"
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
    }
    
    private func setupTableView() {
        listView.tableView.delegate = self
        listView.tableView.dataSource = self
        listView.tableView.rowHeight = UITableView.automaticDimension
        listView.tableView.estimatedRowHeight = 60
        listView.tableView.register(AirportTableViewCell.self, forCellReuseIdentifier: NSStringFromClass(AirportTableViewCell.self))
    }
    
    @MainActor
    private func handleState() {
        switch viewModel.state {
        case .loading:
            listView.activityIndicator.startAnimating()
            listView.tableView.isHidden = true
        case .finishedLoading:
            listView.activityIndicator.stopAnimating()
            listView.tableView.isHidden = false
            listView.tableView.reloadData()
            listView.tableView.layoutIfNeeded()
        case .error(let error):
            listView.activityIndicator.stopAnimating()
            listView.tableView.isHidden = false
            presentError(error: error)
        }
    }

    @MainActor
    private func presentError(error: Error) {
        let ac = UIAlertController(
            title: "Error",
            message: error.localizedDescription,
            preferredStyle: .alert
        )
        let submitAction = UIAlertAction(title: "Ok :(", style: .default)
        ac.addAction(submitAction)
        present(ac, animated: true)
    }
}

extension ListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.airports.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(AirportTableViewCell.self), for: indexPath) as? AirportTableViewCell else {
            fatalError("Cannot dequeue reusable cell.")
        }
        let cellViewModel = cellViewModelFactory(viewModel.airports[indexPath.row])
        cell.configure(with: cellViewModel)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.showDetails(at: indexPath.row)
    }
}

extension ListViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        Task { [weak self] in
            guard let self = self,
                  let airportCode = self.searchController.searchBar.text?.trimmingCharacters(in: .whitespacesAndNewlines),
                  !airportCode.isEmpty
            else { return }
            await self.viewModel.addAirport(airportCode)
        }
        searchController.searchBar.resignFirstResponder()
    }
}
