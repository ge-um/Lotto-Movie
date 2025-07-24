//
//  ViewController.swift
//  Lotto+Movie
//
//  Created by 금가경 on 7/23/25.
//

import SnapKit
import UIKit

class NavigationViewController: UIViewController {
    // TODO: button configuration에서 색상을 먼저 적용하면 폰트 적용이 안되는 이슈? configuration.attributedTitle이 nil이라기엔 Default는 됨.
    let lottoButton: UIButton = {
        let button = NavigationButton()
        button.setTitle("Lotto", for: .normal)
        return button
    }()
    
    let movieButton = {
        let button = NavigationButton()
        button.setTitle("Movie", for: .normal)
        return button
    }()
    
    // TODO: - 이 StackView를 이 바깥에 빼놔야되나? 그냥 레이아웃 틀인데..
    let stackView = UIStackView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureSubviews()
        configureConstraints()
        configureStyle()
        bindAction()
        configureNavigation()
    }
}

extension NavigationViewController {
    func configureSubviews() {
        stackView.addArrangedSubview(lottoButton)
        stackView.addArrangedSubview(movieButton)
        
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 30
        
        view.addSubview(stackView)
    }
    
    func configureConstraints() {
        lottoButton.snp.makeConstraints { make in
            make.height.equalTo(44)
        }
        
        movieButton.snp.makeConstraints { make in
            make.height.equalTo(44)
        }
        
        stackView.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(60)
            make.centerY.equalToSuperview()
        }
    }
    
    func configureStyle() {
        view.backgroundColor = .white
    }
    
    func bindAction() {
        lottoButton.addTarget(self, action: #selector(lottoButtonTapped), for: .touchUpInside)
        movieButton.addTarget(self, action: #selector(movieButtonTapped), for: .touchUpInside)
    }
    
    func configureNavigation() {
        let backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        backBarButtonItem.tintColor = .darkGray
        navigationItem.backBarButtonItem = backBarButtonItem
    }
    
    @objc func lottoButtonTapped() {
        let vc = LottoViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func movieButtonTapped() {
        let vc = MovieViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}
