//
//  CustomTableViewCell.swift
//  HW19
//
//  Created by Павел on 09.03.2023.
//

import UIKit
import SnapKit

class CustomTableViewCell: UITableViewCell {
    static let id = String(describing: CustomTableViewCell.self)
    let nameLabel = UILabel()
    let surNameLabel = UILabel()
    let ageLabel = UILabel()
    let countryLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        makeConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func makeConstraint() {
        
        addSubview(nameLabel)
        addSubview(surNameLabel)
        addSubview(ageLabel)
        addSubview(countryLabel)
        
        nameLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview()
        }
        surNameLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(nameLabel.snp.bottom)
        }
        ageLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(surNameLabel.snp.bottom)
        }
        countryLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(ageLabel.snp.bottom)
        }

    }
    

}
