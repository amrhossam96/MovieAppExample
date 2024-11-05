//
//  SearchViewController.swift
//  Presentation
//
//  Created by Amr on 05/11/2024.
//

import UIKit
import struct Core.PresentableMovie
import Combine

class SearchCellView: UICollectionViewCell {
    
    static var identifier: String = "SearchCellView"
    private let imageView: CustomImageView = {
        let imageView = CustomImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
    
    override func prepareForReuse() {
        imageView.image = nil
    }
    
    func configure(urlString: String) {
        imageView.setImage(from: urlString)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}

class SearchViewController: UIViewController {
    
    private let searchViewModel: SearchViewModel
    private var subscriptions: Set<AnyCancellable> = []

    
    init(searchViewModel: SearchViewModel) {
        self.searchViewModel = searchViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    private func configureConstraints() {
        collectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func bindView() {
        searchViewModel.$searchedItems.sink { [weak self] _ in
            guard let self else { return }
            collectionView.reloadData()
        }
        .store(in: &subscriptions)
    }
    
    private lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: 120, height: 170)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(SearchCellView.self, forCellWithReuseIdentifier: SearchCellView.identifier)
        collectionView.dataSource = self
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(collectionView)
        configureConstraints()
        bindView()
    }
}

extension SearchViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        searchViewModel.searchedItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchCellView.identifier,
                                                            for: indexPath) as? SearchCellView else {
            return UICollectionViewCell()
        }
        
        cell.configure(urlString: searchViewModel.searchedItems[indexPath.row].image.absoluteString)
        return cell
    }
}


class SearchViewModel: ObservableObject {
    @Published var searchedItems: [PresentableMovie] = []
}
