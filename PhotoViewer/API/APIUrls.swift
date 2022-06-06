//
//  APIUrls.swift
//  PhotoViewer
//
//  Created by Alex Kulish on 06.06.2022.
//

import Foundation

enum APIUrls {
    case randomPhotos(count: Int)
    case searchPhotos(query: String, count: Int)
    
    var url: URL? {
        let baseURL = APIConstant.baseURL
        
        switch self {
        case .randomPhotos(let count):
            let stringURL = baseURL + "/photos/random?count=\(count)"
            return URL(string: stringURL)
        case let .searchPhotos(query, count):
            let stringURL = baseURL + "/search/photos?query=\(query)&order_by=relevant&per_page=\(count)"
            return URL(string: stringURL.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed) ?? "")
        }
    }
    
}
