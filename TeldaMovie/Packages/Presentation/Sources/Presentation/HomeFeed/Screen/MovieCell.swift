//
//  File.swift
//  Presentation
//
//  Created by Amr on 05/11/2024.
//

import UIKit
import struct Core.PresentableMovie

class MovieCell: UICollectionViewCell {
    static let identifier: String = "MovieCell"
    
    private let movieTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 22, weight: .semibold)
        label.text = "Movie title"
        label.numberOfLines = 0
        return label
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .red
        return imageView
    }()
    
    private let releaseYearLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.text = "2020"
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
        contentView.addSubview(movieTitle)
        contentView.addSubview(releaseYearLabel)
        configureConstraints()
    }
    
    private func configureConstraints() {
        let imageViewContraints = [
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.centerXAnchor),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ]
        
        let movieTitleConstraints = [
            movieTitle.leadingAnchor.constraint(equalTo: contentView.centerXAnchor, constant: 16),
            movieTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            movieTitle.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: -10),
        ]
        
        let releaseYearLabelConstraints = [
            releaseYearLabel.leadingAnchor.constraint(equalTo: movieTitle.leadingAnchor),
            releaseYearLabel.topAnchor.constraint(equalTo: movieTitle.bottomAnchor, constant: 8)
        ]
        
        NSLayoutConstraint.activate(imageViewContraints)
        NSLayoutConstraint.activate(movieTitleConstraints)
        NSLayoutConstraint.activate(releaseYearLabelConstraints)
    }
    
    required init?(coder: NSCoder) {
        fatalError("failed to initialize from coder")
    }
    
    func configure(with presentableMovie: PresentableMovie) {
        movieTitle.text = presentableMovie.title
        let year = Calendar.current.component(.year, from: presentableMovie.year)
        releaseYearLabel.text = "\(year)"
    }
}
