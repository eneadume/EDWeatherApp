//
//  AddCityTableViewCell.swift
//  weather-app
//
//  Created by Enea Dume on 1.7.21.
//

import UIKit

class AddCityTableViewCell: UITableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
