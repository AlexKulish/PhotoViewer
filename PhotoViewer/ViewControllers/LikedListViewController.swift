//
//  LikedListViewController.swift
//  PhotoViewer
//
//  Created by Alex Kulish on 06.06.2022.
//

import UIKit

class LikedListViewController: UIViewController {
    
    private var photos: [Photo]!
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: view.bounds)
        tableView.register(LikedPhotosCell.self, forCellReuseIdentifier: "likedCell")
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    init(photos: [Photo]) {
        super.init(nibName: nil, bundle: nil)
        self.photos = photos
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(tableView)
        getRandomPhotos()
    }
    
    private func getRandomPhotos() {
        NetworkManager.shared.fetchRandomPhotos(count: 50) { [weak self] result in
            switch result {
            case .success(let photos):
                self?.photos = photos
                self?.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
    
}

extension LikedListViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        photos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "likedCell", for: indexPath) as? LikedPhotosCell else { return UITableViewCell() }
        cell.configure(with: photos[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = DetailsViewController()
        vc.photo = photos[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        120
    }
    
    
}
