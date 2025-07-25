//
//  MovieTableViewCell.swift
//  Lotto+Movie
//
//  Created by 금가경 on 7/23/25.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    static let identifier = "MovieTableViewCell"
    
    var movieNumber: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.font = .systemFont(ofSize: 15, weight: .bold)
        label.textAlignment = .center
        
        return label
    }()
    
    var movieTitle: UILabel = {
       let label = UILabel()
        
        label.textColor = .white
        label.font = .systemFont(ofSize: 15, weight: .bold)
        
        return label
    }()
    
    var movieReleaseDate: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 11, weight: .light)
        label.textColor = .white

        return label
    }()
    
    let movieCell: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.spacing = 16
        
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        configureStyle()
        configureSubviews()
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MovieTableViewCell: CustomViewProtocol {
    internal func configureStyle() {
        backgroundColor = .clear
    }
    
    internal func configureSubviews() {
        movieCell.addArrangedSubview(movieNumber)
        movieCell.addArrangedSubview(movieTitle)
        movieCell.addArrangedSubview(movieReleaseDate)
        
        contentView.addSubview(movieCell)
    }
    
    internal func configureConstraints() {
        movieNumber.snp.makeConstraints { make in
            make.width.equalTo(30)
        }
        movieReleaseDate.snp.makeConstraints { make in
            make.width.equalTo(68)
        }
        movieCell.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(10)
        }
    }
    
    func configureData(movie: DailyBoxOfficeList) {
        movieNumber.text = movie.rank
        movieTitle.text = movie.movieNm
        movieReleaseDate.text = movie.openDt
    }
}
