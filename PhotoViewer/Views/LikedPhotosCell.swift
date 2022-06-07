//
//  LikedPhotosCell.swift
//  PhotoViewer
//
//  Created by Alex Kulish on 07.06.2022.
//

import Kingfisher

class LikedPhotosCell: UITableViewCell {
    
    lazy var tableImageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 10, y: 10, width: 100, height: 100))
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        addSubview(imageView)
        return imageView
    }()
    
    lazy var label: UILabel = {
        let label = UILabel(frame: CGRect(x: 120, y: 45, width: self.frame.width - 130, height: 30))
        label.font = .systemFont(ofSize: 20)
        label.textAlignment = .center
        addSubview(label)
        return label
    }()
    
    func configure(with photo: Photo?) {
        label.text = "Photo by \(photo?.user.username ?? "unknown user")"
        tableImageView.kf.setImage(with: URL(string: photo?.urls.small ?? ""))
    }
    
}
