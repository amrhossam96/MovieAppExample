//
//  HomeFeedViewController.swift
//  Presentation
//
//  Created by Amr on 04/11/2024.
//

import UIKit
import Combine

class HomeFeedViewController: UIViewController {
    private var subscriptions: Set<AnyCancellable> = []
    let viewModel: HomeFeedViewModel

    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: view.bounds.width - 32, height: 250)
        layout.sectionInset = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(MovieCell.self, forCellWithReuseIdentifier: MovieCell.identifier)
        collectionView.register(
            HeaderView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: HeaderView.identifier
        )
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private let searchViewModel = SearchViewModel()
    private lazy var searchController = UISearchController(
        searchResultsController: SearchViewController(searchViewModel: searchViewModel)
    )

    init(viewModel: HomeFeedViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad()
        searchController.searchResultsUpdater = self
        view.backgroundColor = .systemBackground
        navigationItem.searchController = searchController
        title = "Top Rated"
        view.addSubview(collectionView)
        collectionView.dataSource = self
        collectionView.delegate = self
        configureConstraints()
        bindCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
    }
    
    private func bindCollectionView() {
        viewModel.$presentableFeed
            .sink { [weak self] _ in
                guard let self else { return }
                collectionView.reloadData()
            }
            .store(in: &subscriptions)
        
        viewModel.$searchedMovies.sink { [weak self] feed in
            guard let self, let groupedFeed = feed?.feed else { return }
            searchViewModel.searchedItems = groupedFeed.groupedMovies.flatMap(\.1)
        }
        .store(in: &subscriptions)
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension HomeFeedViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        CGSize(width: view.bounds.width, height: 40)
    }
}
extension HomeFeedViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.presentableFeed?.feed.groupedMovies.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.presentableFeed?.feed.groupedMovies[section].1.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCell.identifier, for: indexPath) as? MovieCell, let movie = (viewModel.presentableFeed?.feed.groupedMovies[indexPath.section].1[indexPath.item]) else {
            return UICollectionViewCell()
        }
        cell.configure(with: movie)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionHeader else {
            return UICollectionReusableView()
        }
        let headerView = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: HeaderView.identifier,
            for: indexPath
        ) as! HeaderView
        
        let year = viewModel.presentableFeed?.feed.groupedMovies[indexPath.section].0 ?? Date()
        let yearComponent = Calendar.current.component(.year, from: year)
        headerView.configure(with: "\(yearComponent)")
        return headerView
    }
}

extension HomeFeedViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.didSelectItem(at: indexPath.section, row: indexPath.row)
    }
}

extension HomeFeedViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else { return }
        viewModel.didTypeInSearchBar(text: searchText)
    }
}
