//
//  MoviesDataSource.swift
//  MoviesIos
//
//  Created by Alican SEKBAN on 25.01.2025.
//

import Foundation

class MoviesDataSource {
    private let baseURL = "https://api.themoviedb.org/3/movie/popular"
    private let accessToken = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI3OGUzZDUxYjYwYzZiN2E3NzU3N2JkNzNmODI3MTEzOCIsInN1YiI6IjVkZmRmOGEwZDFhODkzMDAxNDg2ZjIzZCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.8pncezOjkKsif20QbFwy4GO_1dxOt9Rfdt-EFBQ5EDE"
    
    func fetchPopularMovies(page: Int = 1, completion: @escaping (Result<[MovieData], Error>) -> Void) {
        guard var urlComponents = URLComponents(string: baseURL) else {
            completion(.failure(NSError(domain: "Invalid URL", code: 400, userInfo: nil)))
            return
        }
        
        // Query params
        urlComponents.queryItems = [
            URLQueryItem(name: "language", value: "en-US"),
            URLQueryItem(name: "page", value: "\(page)")
        ]
        
        guard let url = urlComponents.url else {
            completion(.failure(NSError(domain: "URL Generation Failed", code: 400, userInfo: nil)))
            return
        }
        
        print("Generated URL: \(url)")
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "No Data", code: 500, userInfo: nil)))
                return
            }
            
            print("Received Data: \(data)")
            
            do {
                let decodedResponse = try JSONDecoder().decode(MovieResponse.self, from: data)
                completion(.success(decodedResponse.results))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}

// Response Model
struct MovieResponse: Decodable {
    let results: [MovieData]
}

// Movie Model
struct MovieData: Decodable, Identifiable {
    let id: Int
    let title: String
    let vote_average: Double
    let vote_count: Int
    let poster_path: String
}
