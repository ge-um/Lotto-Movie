//
//  MovieViewController.swift
//  Lotto+Movie
//
//  Created by 금가경 on 7/23/25.
//

import SnapKit
import UIKit

class MovieViewController: UIViewController {
    let imageView: UIImageView = {
        let image = UIImage(named: "movie")
        let imageView = UIImageView(image: image)
        
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    let searchTextField: UITextField = {
        let textField = UITextField()
        
        textField.borderStyle = .roundedRect
        textField.layer.borderColor = UIColor.white.cgColor
        textField.layer.borderWidth = 1
        textField.backgroundColor = .clear
        
        return textField
    }()
    
    let searchButton: UIButton = {
        let button = UIButton()
        
        button.backgroundColor = .white
        button.setTitle("검색", for: .normal)
        button.setTitleColor(.black, for: .normal)
        
        return button
    }()

    let searchBar: UIStackView = {
        let stackView = UIStackView()
        
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 16
        return stackView
    }()
    
    let tableView = UITableView()
    
    var movies = MovieInfo.movies
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureDependency()
        configureLayout()
        configureUI()
        
        searchTextField.delegate = self
        searchButton.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
    }
    
    // MARK: - Action
    func shuffleData() {
        movies.shuffle()
        tableView.reloadData()
    }
    
    @objc func searchButtonTapped() {
        shuffleData()
        view.endEditing(true)
    }
}

extension MovieViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print(#function)
        shuffleData()
        view.endEditing(true)
        return true
    }
}

extension MovieViewController: CustomViewProtocol {
    func configureDependency() {
        view.addSubview(imageView)
        
        searchBar.addArrangedSubview(searchTextField)
        searchBar.addArrangedSubview(searchButton)
        
        view.addSubview(searchBar)
        view.addSubview(tableView)
    }
    
    func configureLayout() {
        imageView.snp.makeConstraints { make in
            make.size.equalToSuperview()
        }
        
        searchBar.snp.makeConstraints {
            make in
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(44)
            make.top.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        tableView.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.top.equalTo(searchBar.snp.bottom).offset(20)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
    }
    
    func configureUI() {
        // TODO: - 네비게이션 바가 잘 안보이는 이슈가 있음.
        view.backgroundColor = .black
        imageView.alpha = 0.5
                
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(MovieTableViewCell.self, forCellReuseIdentifier: "MovieTableViewCell")
        
        tableView.backgroundColor = .clear
    }
}

extension MovieViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieTableViewCell") as! MovieTableViewCell
        
        cell.movieNumber.text = String(indexPath.row + 1)
        cell.movieTitle.text = movies[indexPath.row].title
        cell.date.text = movies[indexPath.row].releaseDate
        
        return cell
    }
}

#Preview {
    MovieViewController()
}
