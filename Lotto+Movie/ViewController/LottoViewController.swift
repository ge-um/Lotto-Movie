//
//  LottoViewController.swift
//  Lotto+Movie
//
//  Created by 금가경 on 7/23/25.
//

import UIKit

class LottoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
}

extension LottoViewController: CustomViewProtocol {
    func configureDependency() {
        
    }
    
    func configureLayout() {
        
    }
    
    func configureUI() {
        view.backgroundColor = .white
    }
}
