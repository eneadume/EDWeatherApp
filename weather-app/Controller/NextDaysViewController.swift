//
//  NextDaysViewController.swift
//  weather-app
//
//  Created by Enea Dume on 30.6.21.
//

import MBProgressHUD

class NextDaysViewController: UIViewController {
    // MARK: - UICOMPONENTS
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.allowsMultipleSelection = false
        tableView.backgroundColor = .white
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        return tableView
    }()
    //MARK: - vars
    var city: City?
    var networkManager: NetworkManager!
    var weatherArray: [Weather]? {
        didSet {
            tableView.reloadData()
        }
    }
    
    init(networkManager: NetworkManager = NetworkManager()) {
        super.init(nibName: nil, bundle: nil)
        self.networkManager = networkManager
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = "Next Days"
        self.setupTablewView()
        guard let woeid = self.city?.woeid else { return }
        self.getWeatherForCity(woeid: woeid)
    }
    
    //add tableView as subview, set constraints and register cells for reuse
    func setupTablewView() {
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        tableView.fillSuperview()
        tableView.register(DailyWeatherTableViewCell.self, forCellReuseIdentifier: DailyWeatherTableViewCell.reuseIdentifier)
    }
    
    func getWeatherForCity(woeid: Int) {
        MBProgressHUD.showAdded(to: self.view, animated: true)
        networkManager.getCityWeather(woeid: woeid) { [weak self] (city, error) in
            guard let self = self else { return }
            if let city = city {
                print(city.title)
                self.weatherArray = city.consolidatedWeather
                MBProgressHUD.hide(for: self.view, animated: true)
            }else {
                MBProgressHUD.hide(for: self.view, animated: true)
                print(error ?? "")
            }
        }
    }

}

extension NextDaysViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherArray?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DailyWeatherTableViewCell.reuseIdentifier, for: indexPath) as? DailyWeatherTableViewCell else { return UITableViewCell() }
        if let weather = weatherArray?[indexPath.row] {
            cell.weather = weather
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let selectedDate = weatherArray?[indexPath.row] {
            let selectedDateStr = selectedDate.getDateToWeatherFormat(dateString: selectedDate.applicableDate)
            let weatherDetailViewController = CityDetailViewController(weatherDate: selectedDateStr, city: self.city, shouldShowNextDays: false)            
            self.navigationController?.pushViewController(weatherDetailViewController, animated: true)
        }
    }
}
