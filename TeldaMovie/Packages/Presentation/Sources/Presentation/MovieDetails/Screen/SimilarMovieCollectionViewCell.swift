//
//  SimilarMovieCollectionViewCell.swift
//  Presentation
//
//  Created by Amr on 05/11/2024.
//

import UIKit
import struct Core.PresentableMovie

class SimilarMovieCollectionViewCell: UICollectionViewCell {
    
    static var identifier: String = "SimilarMovieCollectionViewCell"
    
    private lazy var posterImageView: CustomImageView = {
        let imageView = CustomImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let movieTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.numberOfLines = 1
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(movieTitleLabel)
        contentView.addSubview(posterImageView)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        contentView.addSubview(posterImageView)
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            posterImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            posterImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            posterImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            movieTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            movieTitleLabel.topAnchor.constraint(equalTo: posterImageView.bottomAnchor, constant: 8),
            movieTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            movieTitleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    func configure(with movie: PresentableMovie) {
        posterImageView.setImage(from: movie.image.absoluteString)
        movieTitleLabel.text = movie.title
    }
    
    override func prepareForReuse() {
        posterImageView.image = nil
        movieTitleLabel.text = nil
    }
}
