import UIKit
import Combine

class MovieDetailsViewController: UIViewController {
    private var subscriptions: Set<AnyCancellable> = []
    
    private let viewModel: MovieDetailsViewModel
    private var actorsViewModel: IndividualsCarouselViewModel?
    private var directorsViewModel: IndividualsCarouselViewModel?
    
    init(viewModel: MovieDetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let movieTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let imageView: CustomImageView = {
        let imageView = CustomImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let overviewLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.alwaysBounceVertical = true
        return scrollView
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let similarLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.text = "Similar Movies"
        return label
    }()
    
    private lazy var similarMoviesCollectionView: UICollectionView = {
        let layoutFlow = UICollectionViewFlowLayout()
        layoutFlow.scrollDirection = .horizontal
        layoutFlow.itemSize = CGSize(width: 140, height: 170)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layoutFlow)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(
            SimilarMovieCollectionViewCell.self,
            forCellWithReuseIdentifier: SimilarMovieCollectionViewCell.identifier
        )
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    
    private lazy var actorsMembersView: IndividualsCarouselViewController = {
        actorsViewModel = IndividualsCarouselViewModel(title: "Actors")
        let viewController = IndividualsCarouselViewController(viewModel: actorsViewModel!)
        viewController.view.translatesAutoresizingMaskIntoConstraints = false
        return viewController
    }()
    
    private lazy var directorsMembersView: IndividualsCarouselViewController = {
        directorsViewModel = IndividualsCarouselViewModel(title: "Directors")
        let viewController = IndividualsCarouselViewController(viewModel: directorsViewModel!)
        viewController.view.translatesAutoresizingMaskIntoConstraints = false
        return viewController
    }()
    
    private let similarActorsTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        return label
    }()
    
    private func addChildren() {
        addChild(actorsMembersView)
        view.addSubview(actorsMembersView.view)
        
        addChild(directorsMembersView)
        view.addSubview(directorsMembersView.view)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupUI()
        setupBindings()
        addChildren()
        setupConstraints()
        viewModel.viewDidLoad()
    }
    
    private func setupUI() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        let components: [UIView] = [
            imageView, movieTitleLabel, overviewLabel,
            similarLabel,
            similarActorsTitle,
            similarMoviesCollectionView,
        ]
        
        components.forEach { contentView.addSubview($0) }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationItem.largeTitleDisplayMode = .automatic
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            imageView.heightAnchor.constraint(equalToConstant: 350),
            
            movieTitleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 16),
            movieTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            
            overviewLabel.topAnchor.constraint(equalTo: movieTitleLabel.bottomAnchor, constant: 16),
            overviewLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            overviewLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            similarLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            similarLabel.topAnchor.constraint(equalTo: overviewLabel.bottomAnchor, constant: 16),
            similarLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            
            similarMoviesCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            similarMoviesCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            similarMoviesCollectionView.topAnchor.constraint(equalTo: similarLabel.bottomAnchor, constant: 8),
            similarMoviesCollectionView.heightAnchor.constraint(equalToConstant: 200),
            
            similarActorsTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            similarActorsTitle.topAnchor.constraint(equalTo: similarMoviesCollectionView.bottomAnchor, constant: 16),
            similarActorsTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            actorsMembersView.view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            actorsMembersView.view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            actorsMembersView.view.topAnchor.constraint(equalTo: similarActorsTitle.bottomAnchor, constant: 16),
            actorsMembersView.view.heightAnchor.constraint(equalToConstant: 140),

            directorsMembersView.view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            directorsMembersView.view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            directorsMembersView.view.topAnchor.constraint(equalTo: actorsMembersView.view.bottomAnchor, constant: 4),
            directorsMembersView.view.heightAnchor.constraint(equalToConstant: 140),
            directorsMembersView.view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ])
    }
    
    
    private func setupBindings() {
        viewModel.$presentableMovieDetails
            .sink { [weak self] details in
                guard let self = self, let details = details else { return }
                self.movieTitleLabel.text = details.title
                self.imageView.setImage(from: details.image.absoluteString)
                self.overviewLabel.text = details.overView
            }
            .store(in: &subscriptions)
        
        viewModel.$similarMovies
            .sink { [weak self] _ in
                self?.similarMoviesCollectionView.reloadData()
            }
            .store(in: &subscriptions)
        
        viewModel.$similarMovieActors
            .sink { [weak self] result in
                guard let self else { return }
                actorsViewModel?.individuals = result
            }
            .store(in: &subscriptions)
        
        viewModel.$similarMovieDirectors
            .sink { [weak self] result in
                guard let self else { return }
                directorsViewModel?.individuals = result
            }
            .store(in: &subscriptions)
        
        viewModel.$selectedSimilarMovie.sink { [weak self] movie in
            guard let self, let movie = movie else { return }
            similarLabel.text = "Discover the cast of \(movie.title)"
        }
        .store(in: &subscriptions)
    }
}

extension MovieDetailsViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.similarMovies.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SimilarMovieCollectionViewCell.identifier,
                                                            for: indexPath) as? SimilarMovieCollectionViewCell
        else { return UICollectionViewCell() }
        cell.configure(with: viewModel.similarMovies[indexPath.row])
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movie = viewModel.similarMovies[indexPath.row]
        viewModel.didSelectSimilarMovie(with: movie)
    }
}
