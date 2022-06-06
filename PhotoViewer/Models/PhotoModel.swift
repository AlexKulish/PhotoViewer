//
//  PhotoModel.swift
//  PhotoViewer
//
//  Created by Alex Kulish on 06.06.2022.
//

import Foundation

struct PhotoModel: Codable {
    let total: Int
    let results: [Photo]
}

struct Photo: Codable {
    let id: String
    let createdAt: String
    let width, height: Int
    let urls: Urls
    let likes: Int
    let likedByUser: Bool
    var isFavoritePhoto = false
    let user: User
    
    enum CodingKeys: String, CodingKey {
        case id
        case createdAt = "created_at"
        case width, height, urls, likes
        case likedByUser = "liked_by_user"
        case user
    }
}

struct Urls: Codable {
    let raw, full, regular, small: String
    let thumb, smallS3: String
    
    enum CodingKeys: String, CodingKey {
        case raw, full, regular, small, thumb
        case smallS3 = "small_s3"
    }
}

struct User: Codable {
    let username: String
    let location: String?
}

