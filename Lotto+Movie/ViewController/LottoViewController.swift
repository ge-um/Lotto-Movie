//
//  LottoViewController.swift
//  Lotto+Movie
//
//  Created by 금가경 on 7/23/25.
//

import SnapKit
import UIKit

// TODO: Refactoring 필요..
class LottoViewController: UIViewController {
    // MARK: - Views
    let roundTextField: UITextField = {
        let textField = UITextField()
        
        textField.borderStyle = .roundedRect

        return textField
    }()
    
    let pickerView: UIPickerView = {
        let pickerView = UIPickerView()
        
        return pickerView
    }()

    let winningNumberInfoLabel: UILabel = {
        let label = UILabel()
        label.text = "당첨번호 안내"
        label.font = .systemFont(ofSize: 15, weight: .regular)
        
        return label
    }()
    
    let drawDateLabel: UILabel = {
        let label = UILabel()
        label.text = "2022-05-30 추첨"
        label.font = .systemFont(ofSize: 12, weight: .light)
        label.textColor = .darkGray
        
        return label
    }()
    
    let resultLabel = ResultLabel()
    
    let lineView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray5
        
        return view
    }()
    
    let plusImageView = PlusView()
    
    let bonusLottoBall: UIView = {
        let lottoBallView = LottoBallView()
        let label = UILabel()
        
        label.text = "보너스"
        label.font = .systemFont(ofSize: 12)
        label.textColor = .darkGray
        
        let stackView = UIStackView(arrangedSubviews: [lottoBallView, label])
        stackView.axis = .vertical
        stackView.spacing = 4
        stackView.alignment = .center
        
        return stackView
    }()
    
    // MARK: - StackView
    let lottoInfoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .equalCentering
        
        return stackView
    }()
    
    let lottoBallStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.alignment = .firstBaseline
        
        return stackView
    }()
    
    let verticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 16
        
        return stackView
    }()
    
    let rounds = (1...1181).map { Int($0) }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureDependency()
        configureLayout()
        configureUI()
        
        pickerView.delegate = self
        pickerView.dataSource = self
        roundTextField.inputView = pickerView
    }
    
    func reloadNumber() {
        for view in lottoBallStackView.arrangedSubviews {
            if let lottoBall = view as? LottoBallView {
                lottoBall.label.text = String((1...45).randomElement()!)
            }
        }
    }
}

extension LottoViewController: CustomViewProtocol {
    func configureDependency() {
        lottoInfoStackView.addArrangedSubview(winningNumberInfoLabel)
        lottoInfoStackView.addArrangedSubview(drawDateLabel)
        
        for _ in 0..<6 {
            let lottoBall = LottoBallView()
            lottoBallStackView.addArrangedSubview(lottoBall)
        }
        
        lottoBallStackView.addArrangedSubview(plusImageView)
        lottoBallStackView.addArrangedSubview(bonusLottoBall)
        
        verticalStackView.addArrangedSubview(roundTextField)
        verticalStackView.addArrangedSubview(lottoInfoStackView)
        verticalStackView.addArrangedSubview(lineView)
        verticalStackView.addArrangedSubview(resultLabel)
        verticalStackView.addArrangedSubview(lottoBallStackView)
        
        view.addSubview(verticalStackView)
    }
    
    func configureLayout() {
        roundTextField.snp.makeConstraints { make in
            make.height.equalTo(44)
        }
        
        lineView.snp.makeConstraints { make in
            make.height.equalTo(1)
        }
        
        lottoInfoStackView.snp.makeConstraints { make in
            make.height.equalTo(20)
        }
        
        lottoBallStackView.snp.makeConstraints { make in
            make.height.equalTo(60)
        }

        verticalStackView.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(16)
            make.top.equalTo(view.safeAreaLayoutGuide).inset(16)
        }
    }
    
    func configureUI() {
        view.backgroundColor = .white
    }
}

extension LottoViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return  1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return rounds.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(rounds[row])
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        roundTextField.text = String(rounds[row])
        reloadNumber()
    }
}
