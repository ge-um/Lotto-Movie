//
//  RoundTextField.swift
//  Lotto+Movie
//
//  Created by 금가경 on 7/23/25.
//

import UIKit

class RoundTextField: UITextField {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.borderStyle = .roundedRect
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
