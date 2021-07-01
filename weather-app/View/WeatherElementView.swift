//
//  WeatherElementView.swift
//  weather-app
//
//  Created by Enea Dume on 29.6.21.
//

import UIKit

class WeatherElementView: UIView {
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(iconImageView)
        addSubview(elementDetailLabel)
        addSubview(elementDescriptionLabel)
        iconImageView.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0))
        elementDetailLabel.anchor(top: iconImageView.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: UIEdgeInsets(top: 5, left: 0, bottom: 0, right: 0), size: .zero)
        elementDescriptionLabel.anchor(top: elementDetailLabel.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: UIEdgeInsets(top: 2, left: 0, bottom: 10, right: 0))
        iconImageView.constrainHeight(constant: 32)
        iconImageView.constrainWidth(constant: 32)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
