//
//  MovieViewController.swift
//  Lotto+Movie
//
//  Created by 금가경 on 7/23/25.
//

import SnapKit
import UIKit

class MovieViewController: UIViewController {
    let backgroundImageView: UIImageView = {
        let image = UIImage(named: "movie")
        let imageView = UIImageView(image: image)
        
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    let searchBar = SearchBar()
    let tableView = UITableView()
    var movies = MovieInfo.movies
    
    lazy var inputDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMdd"
        return formatter
    }()
    
    lazy var outputdateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureDependency()
        configureLayout()
        configureUI()
    }
}

extension MovieViewController: CustomViewProtocol {
    func configureDependency() {
        view.addSubview(backgroundImageView)
        view.addSubview(searchBar)
        view.addSubview(tableView)
    }
    
    func configureLayout() {
        backgroundImageView.snp.makeConstraints { make in
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
        view.backgroundColor = .black
        backgroundImageView.alpha = 0.3
                
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
        
        if let releaseDate = inputDateFormatter.date(from: movies[indexPath.row].releaseDate) {
            let formattedDate =
                outputdateFormatter.string(from: releaseDate)
            cell.date.text = formattedDate
        }
        
        return cell
    }
}

#Preview {
    MovieViewController()
}
