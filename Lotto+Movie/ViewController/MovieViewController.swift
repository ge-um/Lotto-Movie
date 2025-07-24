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
    
    let searchBar = SearchBar()
    let tableView = UITableView()
    var movies: [Movie] = []
    
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
        configureData()
    }
}

extension MovieViewController: CustomViewProtocol {
    func configureData() {
        fetchData()
    }
    
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

extension MovieViewController {
    func fetchData() {
        let url = "https://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=19e95640f81d5ca0abe4c3d77f04eb1d&targetDt=20120101"
        
        AF.request(url, method: .get)
            .responseDecodable(of: BoxOfficeResponse.self) { [weak self] response in
                
                guard let self = self else { return }
                
                switch response.result {
                case .success(let boxOfficeResponse):

                    movies = boxOfficeResponse
                        .boxOfficeResult
                        .dailyBoxOfficeList
                        .map { Movie(title: $0.movieNm,
                                     releaseDate: $0.openDt,
                                     audienceCount: Int($0.audiCnt)!)
                        }
                    
                    self.tableView.reloadData()
                    
                    print(boxOfficeResponse)
                    
                case .failure(let error):
                    print(error)
                }
            }
    }
}

extension MovieViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieTableViewCell") as! MovieTableViewCell
        
        let num = indexPath.row
        let movie = movies[num]
        cell.configureData(num: String(num), movie: movie)
        
        return cell
    }
}

#Preview {
    MovieViewController()
}
