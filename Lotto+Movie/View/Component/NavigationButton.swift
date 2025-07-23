//
//  NavigationButton.swift
//  Lotto+Movie
//
//  Created by 금가경 on 7/23/25.
//

import UIKit

// TODO: - 타이틀을 받아올 순 없나? 아마 초기화 부분을 찾아봐야 할 것으로 추정.
class NavigationButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        self.backgroundColor = .darkGray
        self.layer.cornerRadius = 10
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
