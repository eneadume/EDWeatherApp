//
//  ViewController.swift
//  weather-app
//
//  Created by Enea Dume on 25.6.21.
//

import UIKit

class CitiesViewController: UIViewController {
    // MARK: - UICOMPONENTS
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.allowsMultipleSelection = false
        tableView.backgroundColor = UIColor(hexString: "EBEBEB")
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
        return tableView
    }()
    
    //MARK: - Vars
    var cities: [City] = [City]()
    var cityManager: CitiesManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupNavigationBar()
        self.setupTablewView()
        self.loadCities()
        cityManager = CitiesManager()
    }
    
    // MARK: - Selectors
    @objc func handleAddNewCity(_ sender: UIBarButtonItem?) {
        // TODO:handle add new city
        let addNewCityViewController = AddNewCityViewController(delegate: self)
        let addNewCityNavigationController = UINavigationController(rootViewController: addNewCityViewController)
        addNewCityNavigationController.modalPresentationStyle = .popover
        self.present(addNewCityNavigationController, animated: true, completion: nil)
    }
    
    //MARK: - Other Functions
    func setupNavigationBar() {
        navigationItem.title = "Cities"
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.navigationItem.rightBarButtonItem =  UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(self.handleAddNewCity(_:)))
        self.navigationController?.navigationBar.tintColor = .black
        self.navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor : UIColor.black,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17, weight: .bold)
        ]
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = false
    }

    //load cities from json string located in JSON/json.swift
    func loadCities() {
        do {
            cities = try citiesList.getObject()
            self.tableView.reloadData()
        }catch(let error) {
            print(error.localizedDescription)
            cities = [City]()
        }
    }
    
    //add tableView as subview, set constraints and register cells for reuse
    func setupTablewView() {
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        tableView.fillSuperview()
        tableView.register(CityListTableViewCell.self, forCellReuseIdentifier: CityListTableViewCell.reuseIdentifier)
    }
    
}


extension CitiesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CityListTableViewCell.reuseIdentifier, for: indexPath) as? CityListTableViewCell else {
            return UITableViewCell()
        }
        let city = self.cities[indexPath.row]
        cell.setCityDetail(city: city)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let cityDetailViewController = CityDetailViewController()
        let selectedCity = self.cities[indexPath.row]
        cityDetailViewController.city = selectedCity
        self.navigationController?.pushViewController(cityDetailViewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
}

extension CitiesViewController: CityDelegate {
    func didAddNewCities(cities: [City]) {
        self.cities = cityManager.mergeCities(existingCities: self.cities, with: cities)
        tableView.reloadData()
    }
}
