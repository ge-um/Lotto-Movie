//
//  ResultLabel.swift
//  Lotto+Movie
//
//  Created by 금가경 on 7/23/25.
//

import UIKit

class ResultLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
                
        let title = "913회 당첨결과"
        self.font = .systemFont(ofSize: 21, weight: .regular)
        
        let attributedString = NSMutableAttributedString(string: title)
        let range = (title as NSString).range(of: "913회")
        attributedString.addAttributes([.foregroundColor: UIColor.systemYellow, .font: UIFont.systemFont(ofSize: 21, weight: .heavy)], range: range)
        self.attributedText = attributedString

        self.textAlignment = .center
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
