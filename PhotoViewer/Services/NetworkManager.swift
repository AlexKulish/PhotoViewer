//
//  NetworkManager.swift
//  PhotoViewer
//
//  Created by Alex Kulish on 06.06.2022.
//

import Foundation

class NetworkManager {
    
    static let shared = NetworkManager()    
    
    private init() {}
    
    
    enum HTTPMethod: String {
        case get = "GET", post = "POST"
    }
    
    func fetchRandomPhotos(count: Int, completion: @escaping (Result<[Photo], Error>) -> Void) {
        guard let url = APIUrls.randomPhotos(count: count).url else { return }
        let request = self.getRequest(url: url, httpMethod: .get)
        self.dataTask(request: request, completion: completion)
    }

    func searchPhotos(count: Int, searchTerm: String, completion: @escaping (Result<PhotoModel?, Error>) -> Void) {
        guard let url = APIUrls.searchPhotos(query: searchTerm, count: count).url else { return }
        let request = self.getRequest(url: url, httpMethod: .get)
        self.dataTask(request: request, completion: completion)

    }

    private func getRequest(url: URL, httpMethod: HTTPMethod) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod.rawValue
        request.addValue("Client-ID \(APIConstant.accessKey)", forHTTPHeaderField: "Authorization")
        return request
    }

    private func dataTask<T: Decodable>(request: URLRequest, completion: @escaping (Result<T, Error>) -> Void) {

        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else { return }
            let decoder = JSONDecoder()
            do {
                let result = try decoder.decode(T.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(result))
                }
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
    
    
}
