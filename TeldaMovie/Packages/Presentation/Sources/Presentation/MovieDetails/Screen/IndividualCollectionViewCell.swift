//
//  IndividualCollectionViewCell.swift
//  Presentation
//
//  Created by Amr on 05/11/2024.
//

import struct Core.PresentableCastMember
import UIKit

class IndividualCollectionViewCell: UICollectionViewCell {
    
    static let identifier: String = "IndividualCollectionViewCell"
    
    private let avatarView: CustomImageView = {
        let imageView = CustomImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 25 // Assuming avatar width/height = 50 for circular view
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private let individualNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .label
        return label
    }()
    
    private let characterNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .secondaryLabel
        return label
    }()
    
    private let popularityLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 12, weight: .light)
        label.textColor = .tertiaryLabel
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(avatarView)
        contentView.addSubview(individualNameLabel)
        contentView.addSubview(characterNameLabel)
        contentView.addSubview(popularityLabel)
        
        configureConstraints()
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            // Avatar constraints
            avatarView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            avatarView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            avatarView.widthAnchor.constraint(equalToConstant: 50),
            avatarView.heightAnchor.constraint(equalToConstant: 50),
            
            // Name label constraints
            individualNameLabel.leadingAnchor.constraint(equalTo: avatarView.trailingAnchor, constant: 12),
            individualNameLabel.topAnchor.constraint(equalTo: avatarView.topAnchor),
            individualNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            // Character name constraints
            characterNameLabel.leadingAnchor.constraint(equalTo: individualNameLabel.leadingAnchor),
            characterNameLabel.topAnchor.constraint(equalTo: individualNameLabel.bottomAnchor, constant: 4),
            characterNameLabel.trailingAnchor.constraint(equalTo: individualNameLabel.trailingAnchor),
            
            // Popularity label constraints
            popularityLabel.leadingAnchor.constraint(equalTo: individualNameLabel.leadingAnchor),
            popularityLabel.topAnchor.constraint(equalTo: characterNameLabel.bottomAnchor, constant: 4),
            popularityLabel.trailingAnchor.constraint(equalTo: individualNameLabel.trailingAnchor),
            popularityLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -16)
        ])
    }
    
    func configure(with model: PresentableCastMember) {
        individualNameLabel.text = model.name
        characterNameLabel.text = model.character
        popularityLabel.text = "Popularity: \(model.popularity)"
        avatarView.setImage(from: model.profilePath)
        print(model.profilePath)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        avatarView.image = nil
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
