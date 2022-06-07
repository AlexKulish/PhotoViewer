//
//  PhotosCell.swift
//  PhotoViewer
//
//  Created by Alex Kulish on 07.06.2022.
//

import Kingfisher

class PhotosCell: UICollectionViewCell {
    
    lazy var image: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height))
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 15
        addSubview(imageView)
        return imageView
    }()
    
    func configure(with photo: Photo?) {
        image.kf.indicatorType = .activity
        image.kf.setImage(with: URL(string: photo?.urls.small ?? ""))
    }

    
}
