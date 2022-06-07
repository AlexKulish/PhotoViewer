//
//  LikedListViewController.swift
//  PhotoViewer
//
//  Created by Alex Kulish on 06.06.2022.
//

import UIKit

class LikedListViewController: UIViewController {
    
    private var favouritePhotos: [Photo] = []
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: view.bounds)
        tableView.register(LikedPhotosCell.self, forCellReuseIdentifier: "likedCell")
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(tableView)
//        getRandomPhotos()
        getFavouritePhoto()
    }
    
//    private func getRandomPhotos() {
//        NetworkManager.shared.fetchRandomPhotos(count: 50) { [weak self] result in
//            switch result {
//            case .success(let photos):
//                self?.photos = photos
//                self?.tableView.reloadData()
//            case .failure(let error):
//                print(error)
//            }
//        }
//    }
    
    private func getFavouritePhoto() {
        
        guard let favPhoto = StorageManager.shared.loadSettingsButtons() else { return }
        favouritePhotos.append(favPhoto)
        tableView.reloadData()
    }
    
}

extension LikedListViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        favouritePhotos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "likedCell", for: indexPath) as? LikedPhotosCell else { return UITableViewCell() }
        cell.configure(with: favouritePhotos[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = DetailsViewController()
        vc.photo = favouritePhotos[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        120
    }
    
    
}
