//
//  IndividualsCarouselViewController.swift
//  Presentation
//
//  Created by Amr on 05/11/2024.
//

import UIKit
import Combine

class IndividualsCarouselViewController: UIViewController {
    
    private let viewModel: IndividualsCarouselViewModel
    private var subscriptions: Set<AnyCancellable> = []
    init(viewModel: IndividualsCarouselViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private lazy var actorsTitle: UILabel = {
        let label = UILabel()
        label.text = viewModel.title
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18, weight: .medium)
        return label
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layoutFlow = UICollectionViewFlowLayout()
        layoutFlow.scrollDirection = .horizontal
        layoutFlow.itemSize = CGSize(width: 200, height: 100)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layoutFlow)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(IndividualCollectionViewCell.self, forCellWithReuseIdentifier: IndividualCollectionViewCell.identifier)
        collectionView.dataSource = self
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(actorsTitle)
        view.addSubview(collectionView)
        configureConstraints()
        viewModel.$individuals.sink { [weak self] _ in
            guard let self else { return}
            collectionView.reloadData()
        }
        .store(in: &subscriptions)
    }
    
    private func configureConstraints() {
        let actorsTitleConstraints = [
            actorsTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            actorsTitle.topAnchor.constraint(equalTo: view.topAnchor)
        ]
        let collectionViewConstraints = [
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.topAnchor.constraint(equalTo: actorsTitle.bottomAnchor, constant: 8),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
        NSLayoutConstraint.activate(actorsTitleConstraints)
        NSLayoutConstraint.activate(collectionViewConstraints)
    }
}

extension IndividualsCarouselViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.individuals.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: IndividualCollectionViewCell.identifier,
                                                            for: indexPath) as? IndividualCollectionViewCell
        
        else { return UICollectionViewCell() }
        cell.configure(with: viewModel.individuals[indexPath.row])
        return cell
    }
}
