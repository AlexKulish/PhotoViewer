//
//  DetailsViewController.swift
//  PhotoViewer
//
//  Created by Alex Kulish on 06.06.2022.
//

import UIKit

class DetailsViewController: UIViewController {
    
    var photo: Photo?
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        view.addSubview(imageView)
        return imageView
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var placeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var downloadCountLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var likeButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
        button.layer.cornerRadius = 15
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = (photo?.isFavoritePhoto ?? false) ? .lightGray : .red
        view.addSubview(button)
        return button
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [nameLabel, dateLabel, placeLabel, downloadCountLabel])
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupConstrains()
        setupPhoto()
        setupUI()
    }
    
    private func setupConstrains() {
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 120),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            imageView.heightAnchor.constraint(equalToConstant: 250)
        ])
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 30),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            likeButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 30),
            likeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 100),
            likeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -100),
            likeButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func setupPhoto() {
        imageView.kf.indicatorType = .activity
        imageView.kf.setImage(with: URL(string: photo?.urls.regular ?? ""))
    }
    
    private func setupUI() {
        
        nameLabel.text = "Photo by \(photo?.user.username ?? "Unknown user")"
        dateLabel.text = "Created at \(photo?.createdAt ?? "Unknown date created")"
        placeLabel.text = "Location: \(photo?.user.location ?? "Unknown location")"
        downloadCountLabel.text = "Likes by \(photo?.likes ?? 0) peoples"
        
        buttonTitleToggle()
        
    }
    
    private func showAlert() {
        let alert = UIAlertController(title: "Cool!", message: photo?.isFavoritePhoto ?? false ? "Photo is liked" : "Photo is unliked", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
    
    func buttonTitleToggle() {
        let liked = photo?.isFavoritePhoto ?? false
        let likeButtonText = liked ? "Unlike" : "Like"
        likeButton.setTitle(likeButtonText, for: .normal)
        DispatchQueue.main.async { [weak self] in
            if liked {
                UIView.animate(withDuration: 1) {
                    self?.likeButton.backgroundColor = UIColor(red: 1.0, green: 0.0, blue: 0.2, alpha: 1.0)
                }
                UIView.animate(withDuration: 0.5) {
                   self?.likeButton.backgroundColor = UIColor.lightGray
                }
            } else {
                UIView.animate(withDuration: 1) {
                  self?.likeButton.backgroundColor = UIColor.red
                }
            }
        }
    }
    
    @objc private func likeButtonTapped() {
        if ((photo?.isFavoritePhoto) != nil) {
            
        }
        photo?.isFavoritePhoto.toggle()
        buttonTitleToggle()
        showAlert()
    }
    
}
