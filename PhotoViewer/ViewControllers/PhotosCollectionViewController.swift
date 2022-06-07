//
//  PhotosCollectionViewController.swift
//  PhotoViewer
//
//  Created by Alex Kulish on 06.06.2022.
//

import UIKit

class PhotosCollectionViewController: UIViewController {
    
    private var photos = [Photo]()
    private var timer: Timer?
    private let customRefreshControl = UIRefreshControl()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createCompositionalLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .white
        collectionView.register(PhotosCell.self, forCellWithReuseIdentifier: "photoCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupSearchBar()
        view.addSubview(collectionView)
        getRandomPhotos()
        
    }
    
    private func setupSearchBar() {
        let searchController = UISearchController(searchResultsController: nil)
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchBar.placeholder = "Search photo"
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
    }
    
    private func createCompositionalLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, layoutEnvironment in
            
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 8)
            
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(250))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 2)
//            let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
            group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 8, trailing: 0)
            
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 20, bottom: 0, trailing: 20)
            
            return section
            
        }
        return layout
    }
    
    private func getRandomPhotos() {
        NetworkManager.shared.fetchRandomPhotos(count: 50) { [weak self] result in
            switch result {
            case .success(let photos):
                self?.photos = photos
                self?.collectionView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func refreshControl() {
        customRefreshControl.addTarget(self, action: #selector(refreshPhotos), for: .valueChanged)
    }
    
    @objc private func refreshPhotos() {
        collectionView.refreshControl = customRefreshControl
        photos = []
        getRandomPhotos()
        collectionView.reloadData()
    }
    
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource

extension PhotosCollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        photos.count
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath) as? PhotosCell else { return UICollectionViewCell() }
        cell.configure(with: photos[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = DetailsViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
}


// MARK: - UISearchBarDelegate

extension PhotosCollectionViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: false, block: { _ in
            NetworkManager.shared.searchPhotos(count: 50, searchTerm: searchText) { [weak self] result in
                print(searchText)
                switch result {
                case .success(let searchResult):
                    guard let searchResult = searchResult else { return }
                    self?.photos = searchResult.results
                    self?.collectionView.reloadData()
                case .failure(let error):
                    print(error)
                }
            }
        })
    }
    
}
