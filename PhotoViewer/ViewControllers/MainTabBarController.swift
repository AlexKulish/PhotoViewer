//
//  MainTabBarController.swift
//  PhotoViewer
//
//  Created by Alex Kulish on 06.06.2022.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    private var photos = [Photo]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.tintColor = .purple
        viewControllers = [
        setupNavigationController(rootViewController: PhotosCollectionViewController(photos: photos), title: "Photos", image: "camera"),
        setupNavigationController(rootViewController: LikedListViewController(photos: photos), title: "Liked", image: "heart")
        ]
        
    }
    
    private func setupNavigationController(rootViewController: UIViewController, title: String, image: String) -> UIViewController {
        
        let navController = UINavigationController(rootViewController: rootViewController)
        navController.navigationBar.prefersLargeTitles = true
        navController.tabBarItem.title = title
        navController.tabBarItem.image = UIImage(systemName: image)
        
        rootViewController.navigationItem.title = title
        return navController
    }
    
}
