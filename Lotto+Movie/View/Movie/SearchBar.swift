//
//  SearchBar.swift
//  Lotto+Movie
//
//  Created by 금가경 on 7/24/25.
//

import UIKit

class SearchBar: UIStackView {
    let textField: UITextField = {
        let textField = UITextField()
        
        textField.borderStyle = .roundedRect
        textField.layer.borderColor = UIColor.white.cgColor
        textField.layer.borderWidth = 1
        textField.backgroundColor = .clear
        textField.keyboardType = .numberPad
        textField.textColor = .white
                
        return textField
    }()
    
    let button: UIButton = {
        let button = UIButton()
        
        button.backgroundColor = .white
        
        let attributedString = NSAttributedString(string: "검색", attributes: [.font: UIFont.systemFont(ofSize: 13)])
        button.setAttributedTitle(attributedString, for: .normal)
        button.setTitleColor(.black, for: .normal)
        
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// TODO: - Responder Chain 알아보기
extension SearchBar: UITextFieldDelegate {
    func configure() {
        textField.delegate = self
        
        self.axis = .horizontal
        self.distribution = .fill
        self.spacing = 16
        
        self.addArrangedSubview(textField)
        self.addArrangedSubview(button)
        
        button.snp.makeConstraints { make in
            make.width.equalTo(60)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print(#function)
        textField.resignFirstResponder()
        return true
    }
    
}
