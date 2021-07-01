//
//  DayWeatherCollectionViewCell.swift
//  weather-app
//
//  Created by Enea Dume on 30.6.21.
//

import Kingfisher

class DayWeatherCollectionViewCell: UICollectionViewCell {
    let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    let elementDetailLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    let elementDescriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .lightGray
        label.textAlignment = .center
        return label
    }()
    
    static var reuseIdentifier: String {
        return "DayWeatherCollectionViewCell"
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        contentView.layer.cornerRadius = 10
        contentView.addSubview(iconImageView)
        contentView.addSubview(elementDetailLabel)
        contentView.addSubview(elementDescriptionLabel)
        elementDetailLabel.anchor(top: contentView.topAnchor, leading: contentView.leadingAnchor, bottom: nil, trailing: contentView.trailingAnchor, padding: UIEdgeInsets(top: 5, left: 0, bottom: 0, right: 0), size: .zero)

        iconImageView.anchor(top: elementDetailLabel.bottomAnchor, leading: contentView.leadingAnchor, bottom: nil, trailing: contentView.trailingAnchor, padding: UIEdgeInsets(top: 8, left: 0, bottom: 0, right: 0))
        elementDescriptionLabel.anchor(top: iconImageView.bottomAnchor, leading: contentView.leadingAnchor, bottom: contentView.bottomAnchor, trailing: contentView.trailingAnchor, padding: UIEdgeInsets(top: 8, left: 0, bottom: 10, right: 0))
        iconImageView.constrainHeight(constant: 32)
        iconImageView.constrainWidth(constant: 32)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        iconImageView.image = nil
        elementDetailLabel.text = ""
        elementDescriptionLabel.text = ""
    }
    
    func fillCellWithDetails(weatherDetail: Weather, router: WeatherAPI) {
        elementDetailLabel.text = weatherDetail.getFormattedTemperature(temperature: weatherDetail.theTemp)
        elementDescriptionLabel.text = weatherDetail.getTimeFromDate(dateString: weatherDetail.created)
        let url = URL(string: router.baseURL.absoluteString + "static/img/weather/png/64/\(weatherDetail.weatherStateAbbr).png")
        iconImageView.kf.setImage(with: url)
    }
}
