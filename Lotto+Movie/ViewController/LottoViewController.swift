//
//  LottoViewController.swift
//  Lotto+Movie
//
//  Created by 금가경 on 7/23/25.
//

import Alamofire
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
    
    var resultLabel = ResultLabel(drawNumber: 1181)
    
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
    var currentLottery: Lottery?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureDependency()
        configureLayout()
        configureUI()
        
        pickerView.delegate = self
        pickerView.dataSource = self
        roundTextField.inputView = pickerView
        
        fetchLotteryNumber()
    }
    
    // TODO: need refactoring
    func reloadNumber() {
        guard let currentLottery = currentLottery else { return }
        let nums: [Int] = [
            currentLottery.drwtNo1,
            currentLottery.drwtNo2,
            currentLottery.drwtNo3,
            currentLottery.drwtNo4,
            currentLottery.drwtNo5,
            currentLottery.drwtNo6,
            currentLottery.bnusNo
        ]
        
        var idx = 0
        for view in lottoBallStackView.arrangedSubviews {
            if let lottoBall = view as? LottoBallView {
                lottoBall.label.text = "\(nums[idx])"
                idx += 1
            }
        }
        
        drawDateLabel.text = "\(currentLottery.drwNoDate) 추첨"
    }
    
    func fetchLotteryNumber(round: Int = 1181) {
        let url = "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=\(round)"
        
        AF.request(url, method: .post)
            .responseDecodable(of: Lottery.self) { [weak self] response in
                guard let self = self else { return }
                switch response.result {
                case .success(let lottery):
                    self.currentLottery = lottery
                    self.reloadNumber()
                    print("success", lottery)
                    
                case .failure(let error):
                    print("error", error)
                }
            }
    }
}

extension LottoViewController {
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
        let round = rounds[row]
        roundTextField.text = String(round)
        resultLabel.updateTitle(drawNumber: round)
        fetchLotteryNumber(round: round)
    }
}
