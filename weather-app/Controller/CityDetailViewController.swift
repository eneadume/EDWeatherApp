//
//  CityDetailViewController.swift
//  weather-app
//
//  Created by Enea Dume on 29.6.21.
//

import MBProgressHUD

class CityDetailViewController: UIViewController {
    //MARK: - UICOMPONENTS
    let containerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 20
        return stackView
    }()
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .clear
        scrollView.isUserInteractionEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.isScrollEnabled = true
        scrollView.alwaysBounceVertical = true
        return scrollView
    }()
    let todayWeatherDetailView = TodayWeatherDetailView()
    let allDayWeatherView = AllDayWeatherView()
    let dispatchGroup = DispatchGroup()
    //MARK: - vars
    var city: City?
    var weathers: [Weather]? {
        didSet {
            allDayWeatherView.weathers = weathers
        }
    }
    var networkManager: NetworkManager!
    var weatherDate: String?
    var shouldShowNextDays = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupNavigationBar()
        self.setupViews()
        guard let woeid = self.city?.woeid else { return }
        dispatchGroup.enter()
        self.getWeatherForCity(woeid: woeid)
        dispatchGroup.notify(queue: .main) {
            self.getWeatherForCity(woeid: woeid, duringDate: self.weatherDate != nil ? (self.weatherDate ?? "") : Date.today())
        }
    }
    
    init(networkManager: NetworkManager = NetworkManager(), weatherDate: String? = nil, city: City? = nil, shouldShowNextDays: Bool = true) {
        super.init(nibName: nil, bundle: nil)
        self.networkManager = networkManager
        self.city = city
        self.weatherDate = weatherDate
        self.shouldShowNextDays = shouldShowNextDays
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupNavigationBar() {
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.navigationController?.navigationBar.barTintColor = .white
        self.navigationController?.navigationBar.tintColor = .black
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationItem.title = city?.title ?? ""
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        self.navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor : UIColor.black,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17, weight: .bold)
        ]
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = false
        view.backgroundColor = .white
    }
    
    func setupViews() {
        view.backgroundColor = UIColor(hexString: "f6f6f6")
        view.addSubview(scrollView)
        scrollView.addSubview(containerStackView)
        scrollView.anchor(top: view.safeTopAnchor, leading: view.leadingAnchor, bottom: view.safeBottomAnchor, trailing: view.leadingAnchor)
        scrollView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: 0).isActive = true
        containerStackView.anchor(top: scrollView.topAnchor, leading: scrollView.leadingAnchor, bottom: scrollView.bottomAnchor, trailing: scrollView.trailingAnchor)
        containerStackView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: 0).isActive = true
        containerStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        //add subviews
        todayWeatherDetailView.constrainHeight(constant: 400)
        allDayWeatherView.constrainHeight(constant: 200)
        allDayWeatherView.delegate = self
        containerStackView.addArrangedSubview(todayWeatherDetailView)
        containerStackView.addArrangedSubview(allDayWeatherView)
        if !shouldShowNextDays {
            allDayWeatherView.weekButton.isHidden = true
        }
        self.updateScrollView()
    }
    
    /**
     get weather for specified city
     */
    func getWeatherForCity(woeid: Int) {
        MBProgressHUD.showAdded(to: self.view, animated: true)
        networkManager.getCityWeather(woeid: woeid) { [weak self] (city, error) in
            guard let self = self else { return }
            if let city = city {
                print(city.title)
                self.todayWeatherDetailView.weather = city.consolidatedWeather?.first
            }else {
                print(error ?? "")
            }
            self.dispatchGroup.leave()
        }
    }
    
    /**
     get weather for specified city and according a date
     */
    func getWeatherForCity(woeid: Int, duringDate date: String) {
        networkManager.getDayWeatherDetails(woeid: woeid, forDate: date) { [weak self](weathers, error) in
            guard let self = self else { return }
            if let weathers = weathers {
                self.weathers = weathers
                MBProgressHUD.hide(for: self.view, animated: true)
            }else {
                print(error ?? "")
                MBProgressHUD.hide(for: self.view, animated: true)
            }
        }
    }
    
    func updateScrollView() {
        var contentRect = CGRect.zero
        for view in scrollView.subviews {
            contentRect = contentRect.union(view.frame)
        }
        scrollView.contentSize = contentRect.size
    }
}

extension CityDetailViewController: WeatherDetailDelegate {
    func didTapNextDays() {
        let nextDaysViewController = NextDaysViewController()
        nextDaysViewController.city = self.city
        self.navigationController?.pushViewController(nextDaysViewController, animated: true)
    }
}
