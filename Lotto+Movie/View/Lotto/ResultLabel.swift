//
//  ResultLabel.swift
//  Lotto+Movie
//
//  Created by 금가경 on 7/23/25.
//

import UIKit

// TODO: - convenience init?
class ResultLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    init(drawNumber: Int) {
        super.init(frame: .zero)
        
        updateTitle(drawNumber: drawNumber)
        self.textAlignment = .center
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateTitle(drawNumber: Int) {
        let title = "\(drawNumber)회 당첨결과"
        self.font = .systemFont(ofSize: 21, weight: .regular)
        
        let attributedString = NSMutableAttributedString(string: title)
        let range = (title as NSString).range(of: "\(drawNumber)회")
        attributedString.addAttributes([.foregroundColor: UIColor.systemYellow, .font: UIFont.systemFont(ofSize: 21, weight: .heavy)], range: range)
        self.attributedText = attributedString
    }
}
