//
//  PlusImageView.swift
//  Lotto+Movie
//
//  Created by 금가경 on 7/23/25.
//

import SnapKit
import UIKit

class PlusView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let label = UILabel()
        
        label.text = "+"
        label.font = .systemFont(ofSize: 15, weight: .bold)
        
        self.addSubview(label)
        
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
