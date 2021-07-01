//
//  TodayWeatherDetailView.swift
//  weather-app
//
//  Created by Enea Dume on 29.6.21.
//

import Kingfisher

class TodayWeatherDetailView: UIView {
    //MARK: - UICOMPONENTS
    let containerView: GrandientView = {
        let view = GrandientView()
        //        view.backgroundColor = UIColor(hexString: "F0EAFB")
        return view
    }()
    let weatherDetailsView: WeatherDetailsView = {
        let view = WeatherDetailsView()
        view.backgroundColor = .white
        view.applyDropShadow()
        view.layer.cornerRadius = 10
        return view
    }()
    let temperatureView: Temperatureview = {
        let view = Temperatureview()
        view.backgroundColor = UIColor(hexString: "ff80ff")
        view.layer.cornerRadius = 65
        return view
    }()
    let weatherIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    var weather: Weather? {
        didSet {
            guard let weather = weather else { return }
            temperatureView.weather = weather
            let url = URL(string: "https://www.metaweather.com/static/img/weather/png/64/\(weather.weatherStateAbbr).png")
            weatherIconImageView.kf.setImage(with: url)
            weatherDetailsView.weather = weather
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        self.addGradient()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        addSubview(containerView)
        containerView.addSubview(weatherDetailsView)
        containerView.addSubview(temperatureView)
        containerView.addSubview(weatherIconImageView)
        containerView.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor)
        weatherDetailsView.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16), size: .zero)
        weatherDetailsView
            .centerYAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 0).isActive = true
        //todo: delete heights
       // weatherDetailsView.constrainHeight(constant: 120)
        temperatureView.constrainHeight(constant: 200)
        //-----
        temperatureView.anchor(top: containerView.topAnchor, leading: nil, bottom: nil, trailing: nil, padding: UIEdgeInsets(top: 16, left: 0, bottom: 0, right: 0), size: .zero)
        temperatureView.centerXInSuperview()
        temperatureView.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.7).isActive = true
        weatherIconImageView.centerXInSuperview()
        weatherIconImageView.centerYAnchor.constraint(equalTo: temperatureView.bottomAnchor).isActive = true
    }
    
    func addGradient(){
        let gradientLayer = containerView.layer as! CAGradientLayer
        gradientLayer.colors = [UIColor(hexString: "ffe2ff")!.cgColor,UIColor.white.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 1)
        gradientLayer.endPoint = CGPoint(x: 0, y: 0)
        gradientLayer.frame = containerView.bounds
    }
}


class GrandientView: UIView {
    override open class var layerClass: AnyClass {
        return CAGradientLayer.classForCoder()
    }
}
