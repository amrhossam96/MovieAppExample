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
    
    private let imageView: CustomImageView = {
        let imageView = CustomImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let voteAverageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.text = "Vote:"
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
        contentView.addSubview(movieTitle)
        contentView.addSubview(voteAverageLabel)
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
            voteAverageLabel.leadingAnchor.constraint(equalTo: movieTitle.leadingAnchor),
            voteAverageLabel.topAnchor.constraint(equalTo: movieTitle.bottomAnchor, constant: 8)
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
        voteAverageLabel.text = "Vote \(presentableMovie.voteAverage)"
        imageView.setImage(from: presentableMovie.image.absoluteString)
    }
}
