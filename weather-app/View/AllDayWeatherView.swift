//
//  AllDayWeatherView.swift
//  weather-app
//
//  Created by Enea Dume on 29.6.21.
//

import UIKit

class AllDayWeatherView: UIView {
    let todayLabel: UILabel = {
        let label = UILabel()
        label.text = "Today"
        label.font = .systemFont(ofSize: 17, weight: .medium)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    let weekButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = .systemFont(ofSize: 17, weight: .medium)
        button.setTitle("Next Days >", for: .normal)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    let collectionView: UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero , collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    var delegate: WeatherDetailDelegate?
    var weathers: [Weather]? {
        didSet {
            collectionView.reloadData()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(hexString: "#f6f6f6")
        addSubview(todayLabel)
        addSubview(weekButton)
        addSubview(collectionView)
        todayLabel.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: nil, padding: UIEdgeInsets(top: 16, left: 16, bottom: 0, right: 0))
        weekButton.anchor(top: todayLabel.topAnchor, leading: nil, bottom: nil, trailing: trailingAnchor, padding: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 16))
        weekButton.addTarget(self, action: #selector(handleNextDaysButton(_:)), for: .touchUpInside)
        collectionView.anchor(top: todayLabel.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: UIEdgeInsets(top: 34, left: 16, bottom: 16, right: 16), size: .zero)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(DayWeatherCollectionViewCell.self, forCellWithReuseIdentifier: DayWeatherCollectionViewCell.reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func handleNextDaysButton(_ sender: UIButton?) {
        delegate?.didTapNextDays()
    }
}

extension AllDayWeatherView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return weathers?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let collectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: DayWeatherCollectionViewCell.reuseIdentifier, for: indexPath) as? DayWeatherCollectionViewCell else {
            return UICollectionViewCell()
        }
        if let weatherDetail = self.weathers?[indexPath.row] {
            collectionViewCell.fillCellWithDetails(weatherDetail: weatherDetail, router: .baseUrl)
        }
        
        return collectionViewCell
    }
}

extension AllDayWeatherView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 65, height: 115);
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
    }
}
