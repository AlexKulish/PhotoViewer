//
//  MainTabBarController.swift
//  PhotoViewer
//
//  Created by Alex Kulish on 06.06.2022.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.tintColor = .purple
        viewControllers = [
        setupNavigationController(rootViewController: PhotosCollectionViewController(), title: "Photos", image: "camera"),
        setupNavigationController(rootViewController: LikedListViewController(), title: "Liked", image: "heart")
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
