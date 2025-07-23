//
//  CustomViewProtocol.swift
//  Lotto+Movie
//
//  Created by 금가경 on 7/23/25.
//

import Foundation

@objc protocol CustomViewProtocol {
    func configureDependency()
    func configureLayout()
    @objc optional func configureUI()
}
