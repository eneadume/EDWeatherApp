//
//  TemperatureView.swift
//  weather-app
//
//  Created by Enea Dume on 29.6.21.
//

import UIKit

class Temperatureview: UIView {
    let weatherStateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 37, weight: .regular)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    let temperatureLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 87, weight: .heavy)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    var weather: Weather? {
        didSet {
            guard let weather = weather else { return }
            weatherStateLabel.text = weather.weatherStateName
            temperatureLabel.text = weather.getFormattedTemperature(temperature: weather.theTemp)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(weatherStateLabel)
        addSubview(temperatureLabel)
        weatherStateLabel.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: UIEdgeInsets(top: 25, left: 18, bottom: 0, right: 18), size: .zero)
        temperatureLabel.anchor(top: weatherStateLabel.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: UIEdgeInsets(top: 10, left: 18, bottom: 18, right: 18), size: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

