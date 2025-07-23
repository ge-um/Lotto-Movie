//
//  LottoBallLabel.swift
//  Lotto+Movie
//
//  Created by 금가경 on 7/23/25.
//

import SnapKit
import UIKit

class LottoBallView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let colorSet: [UIColor] = [.systemYellow, .systemGray, .systemBlue, .systemRed]
        let label = UILabel()
        
        label.text = String((1...45).randomElement()!)
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textColor = .white
        
        self.addSubview(label)
        
        self.backgroundColor = colorSet.randomElement()
        self.layer.cornerRadius = 20
        self.layer.masksToBounds = true
        
        label.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        self.snp.makeConstraints { make in
            make.height.equalTo(40)
            make.width.equalTo(40)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

