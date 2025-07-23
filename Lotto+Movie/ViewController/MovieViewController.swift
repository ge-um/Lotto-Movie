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

    let searchBar: UIStackView = {
        let textField = UITextField()
        
        textField.borderStyle = .roundedRect
        textField.layer.borderColor = UIColor.white.cgColor
        textField.layer.borderWidth = 1
        textField.backgroundColor = .clear
        
        let button = UIButton()
        
        button.backgroundColor = .white
        button.setTitle("검색", for: .normal)
        button.setTitleColor(.black, for: .normal)

        let stackView = UIStackView()
        
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 16
        
        stackView.addArrangedSubview(textField)
        stackView.addArrangedSubview(button)
        
        return stackView
    }()
    
    let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureDependency()
        configureLayout()
        configureUI()
    }
}

extension MovieViewController: CustomViewProtocol {
    func configureDependency() {
        view.addSubview(imageView)
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
        return MovieInfo.movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieTableViewCell") as! MovieTableViewCell
        
        cell.movieNumber.text = String(indexPath.row + 1)
        cell.movieTitle.text = MovieInfo.movies[indexPath.row].title
        cell.date.text = MovieInfo.movies[indexPath.row].releaseDate
        
        return cell
    }
}

#Preview {
    MovieViewController()
}
