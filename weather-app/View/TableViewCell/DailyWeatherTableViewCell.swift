//
//  DailyWeatherTableViewCell.swift
//  weather-app
//
//  Created by Enea Dume on 30.6.21.
//

import UIKit

class DailyWeatherTableViewCell: UITableViewCell {
    let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    let dayLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    let forecastLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = .lightGray
        label.textAlignment = .center
        return label
    }()
    let temperatureLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = .lightGray
        label.textAlignment = .center
        return label
    }()
    
    static var reuseIdentifier: String {
        return "DailyWeatherTableViewCell"
    }
    var weather: Weather? {
        didSet {
            guard let weather = weather else { return }
            forecastLabel.text = weather.weatherStateName
            temperatureLabel.text = weather.getFormattedTemperature(temperature: weather.maxTemp) + " / " + weather.getFormattedTemperature(temperature: weather.minTemp)
            let url = URL(string: WeatherAPI.baseUrl.baseURL.absoluteString + "static/img/weather/png/64/\(weather.weatherStateAbbr).png")
            iconImageView.kf.setImage(with: url)
            dayLabel.text = weather.getDayFromDate(dateString: weather.applicableDate)
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        contentView.addSubview(containerView)
        containerView.addSubview(dayLabel)
        containerView.addSubview(iconImageView)
        containerView.addSubview(forecastLabel)
        containerView.addSubview(temperatureLabel)
        
        //set constraints
        containerView.fillSuperview()
        dayLabel.anchor(top: nil, leading: contentView.leadingAnchor, bottom: nil, trailing: nil, padding: UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 0))
        dayLabel.centerYInSuperview()
        forecastLabel.centerXInSuperview()
        forecastLabel.centerYAnchor.constraint(equalTo: dayLabel.centerYAnchor).isActive = true
        iconImageView.trailingAnchor.constraint(equalTo: forecastLabel.leadingAnchor, constant: -5).isActive = true
        iconImageView.constrainWidth(constant: 32)
        iconImageView.constrainHeight(constant: 32)
        iconImageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -16).isActive = true
        iconImageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16).isActive = true
        
        temperatureLabel.anchor(top: nil, leading: nil, bottom: nil, trailing: containerView.trailingAnchor, padding: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 16))
        temperatureLabel.centerYInSuperview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
