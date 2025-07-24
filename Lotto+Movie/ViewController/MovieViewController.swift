//
//  MovieViewController.swift
//  Lotto+Movie
//
//  Created by 금가경 on 7/23/25.
//

import Alamofire
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
    
    let searchBar = MovieSearchBar()
    let tableView = UITableView()
    var movies: [DailyBoxOfficeList] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSubviews()
        configureConstraints()
        configureStyle()
        configureTableView()
        configureInitialData()
        bindAction()
    }
}

extension MovieViewController: CustomViewProtocol {
    func configureSubviews() {
        view.addSubview(backgroundImageView)
        view.addSubview(searchBar)
        view.addSubview(tableView)
    }
    
    func configureConstraints() {
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
    
    func configureStyle() {
        view.backgroundColor = .black
        backgroundImageView.alpha = 0.3
    }
    
    func configureTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(MovieTableViewCell.self, forCellReuseIdentifier: "MovieTableViewCell")
        tableView.backgroundColor = .clear
    }
    
    func configureInitialData() {
        let formattedYesterday = formattedYesterdayString()
        
        fetchAPI(date: formattedYesterday)
    }
    
    func bindAction() {
        searchBar.button.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
    }
    
    @objc func searchButtonTapped() {
        print(#function)
        searchBar.textField.resignFirstResponder()
        fetchAPI(date: searchBar.textField.text!)
    }
    
    func fetchAPI(date: String = "20250723") {
        let url = "https://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=19e95640f81d5ca0abe4c3d77f04eb1d&targetDt=\(date)"
        
        AF.request(url, method: .get)
            .responseDecodable(of: BoxOfficeResponse.self) { [weak self] response in
                
                guard let self = self else { return }
                
                switch response.result {
                case .success(let boxOfficeResponse):
                    
                    movies = boxOfficeResponse
                        .boxOfficeResult
                        .dailyBoxOfficeList
                        .sorted { Int($0.rank)! < Int($1.rank)! }
                        .prefix(3)
                        .map { $0 }
                    
                    self.tableView.reloadData()
                    
                    print(boxOfficeResponse)
                    
                case .failure(let error):
                    print(error)
                }
            }
    }
    
    private func formattedYesterdayString() -> String {
        guard let yesterdayDate = Calendar.current.date(byAdding: .day, value: -1, to: Date()) else { return "" }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"
        let formattedYesterday = dateFormatter.string(from: yesterdayDate)
        
        return formattedYesterday
    }
}

extension MovieViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return min(movies.count, 3)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieTableViewCell") as! MovieTableViewCell
        
        let movie = movies[indexPath.row]
        cell.configureData(movie: movie)
        
        return cell
    }
}

#Preview {
    MovieViewController()
}
