//
//  AddNewCityViewController.swift
//  weather-app
//
//  Created by Enea Dume on 29.6.21.
//

import UIKit

class AddNewCityViewController: UIViewController {
    // MARK: - UICOMPONENTS
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.allowsMultipleSelection = true
        tableView.backgroundColor = .white
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .singleLine
        return tableView
    }()
    let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.sizeToFit()
        return searchBar
    }()
    //MARK: - vars
    var cities: [City]?
    var networkManager: NetworkManager!
    var citiesManager: CitiesManager!
    var delegate: CityDelegate?
    var weatherArray: [Weather]? {
        didSet {
            tableView.reloadData()
        }
    }
    
    init(networkManager: NetworkManager = NetworkManager(), cityManager: CitiesManager = CitiesManager(), delegate: CityDelegate? = nil) {
        super.init(nibName: nil, bundle: nil)
        self.networkManager = networkManager
        self.citiesManager = cityManager
        self.delegate = delegate
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        searchBar.delegate = self
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(handleDoneButton(_:)))
        navigationItem.titleView = searchBar
        self.setupTablewView()
    }
    //MARK: - Selectors
    @objc func handleDoneButton(_ sender: UIBarButtonItem?) {
        self.dismiss(animated: true) {[weak self] in
            guard let self = self else { return }
            self.delegate?.didAddNewCities(cities: self.citiesManager.getNewCities())
        }
    }
    
    //add tableView as subview, set constraints and register cells for reuse
    func setupTablewView() {
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        tableView.fillSuperview()
        tableView.register(DailyWeatherTableViewCell.self, forCellReuseIdentifier: DailyWeatherTableViewCell.reuseIdentifier)
    }
    
    func getCities(query: String) {
        cities?.removeAll()
        networkManager.getCities(query: query) { [weak self](cities, error) in
            guard let self = self else { return }
            if let cities = cities {
                self.cities = cities
                self.tableView.reloadData()
            }else {
                
            }
        }
    }
    
    func resetSearch() {
        self.cities?.removeAll()
        self.tableView.reloadData()
    }
}

extension AddNewCityViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = AddCityTableViewCell()
        if let city = cities?[indexPath.row] {
            cell.textLabel?.text = city.title
            if citiesManager.containsSelectedCity(city: city) {
                cell.accessoryType = .checkmark
            }else {
                cell.accessoryType = .none
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let city = cities?[indexPath.row] else { return }
        citiesManager.handleCitySelection(city: city)
        tableView.reloadData()
    }
}


extension AddNewCityViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if !searchText.isEmpty {
            self.getCities(query: searchText)
        }else {
            self.resetSearch()
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.resetSearch()
    }
}
