//
//  WeatherDetailsView.swift
//  weather-app
//
//  Created by Enea Dume on 29.6.21.
//

import UIKit

class WeatherDetailsView: UIView {
    //MARK: - UICOMPONENTS
    let weatherDetailsView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 6
        return stackView
    }()
    
    let windView: WeatherElementView = {
        let view = WeatherElementView()
        view.iconImageView.image = UIImage(named: "wind")
        view.elementDescriptionLabel.text = "Wind"
        return view
    }()
    let humidityView: WeatherElementView = {
        let view = WeatherElementView()
        view.iconImageView.image = UIImage(named: "humidity")
        view.elementDescriptionLabel.text = "Humidity"
        return view
    }()
    let visibilityView: WeatherElementView = {
        let view = WeatherElementView()
        view.iconImageView.image = UIImage(named: "visibility")
        view.elementDescriptionLabel.text = "Visibility"
        return view
    }()
    var weather: Weather? {
        didSet {
            guard let weather = weather else { return }
            windView.elementDetailLabel.text =  weather.formatFloatToString(unit: weather.windSpeed) + "mph"
            humidityView.elementDetailLabel.text = weather.humidity.description + " %"
            visibilityView.elementDetailLabel.text = weather.formatFloatToString(unit: weather.visibility) + " mi"
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(weatherDetailsView)
        weatherDetailsView.fillSuperview()
        weatherDetailsView.addArrangedSubview(windView)
        weatherDetailsView.addArrangedSubview(humidityView)
        weatherDetailsView.addArrangedSubview(visibilityView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
