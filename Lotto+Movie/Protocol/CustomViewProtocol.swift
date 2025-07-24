//
//  CustomViewProtocol.swift
//  Lotto+Movie
//
//  Created by 금가경 on 7/23/25.
//

import Foundation

@objc protocol CustomViewProtocol {
    func configureSubviews()
    func configureConstraints()
    func configureStyle()
    @objc optional func configureInitialData()
    @objc optional func bindAction()
}
