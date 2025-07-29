//
//  MoviesDataSource.swift
//  MoviesIos
//
//  Created by Alican SEKBAN on 25.01.2025.
//


import Foundation
import Alamofire

class MoviesDataSource {
    // API'nin farklı bölümleri için temel URL'leri ayırmak daha esnektir.
    private let apiBaseURL = "https://api.themoviedb.org/3"
    private let accessToken = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI3OGUzZDUxYjYwYzZiN2E3NzU3N2JkNzNmODI3MTEzOCIsInN1YiI6IjVkZmRmOGEwZDFhODkzMDAxNDg2ZjIzZCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.8pncezOjkKsif20QbFwy4GO_1dxOt9Rfdt-EFBQ5EDE"

    private var headers: HTTPHeaders {
        ["Authorization": "Bearer \(accessToken)"]
    }

    func fetchPopularMovies(page: Int = 1, completion: @escaping (Result<[MovieData], Error>) -> Void) {
        let url = "\(apiBaseURL)/movie/popular"
        
        let parameters: [String: Any] = [
            "language": "en-US",
            "page": page
        ]
        
        AF.request(url, method: .get, parameters: parameters, headers: headers)
          .validate()
          .responseDecodable(of: MovieResponse.self) { response in
              switch response.result {
              case .success(let movieResponse):
        
                  completion(.success(movieResponse.results))
              case .failure(let error):
                  completion(.failure(error))
              }
          }
    }
    
    func fetchMovieDetail(movieId: Int, completion: @escaping (Result<MovieDetail, Error>) -> Void) {
        let url = "\(apiBaseURL)/movie/\(movieId)"
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        AF.request(url, method: .get, headers: headers)
          .validate()
          .responseDecodable(of: MovieDetail.self, decoder: decoder) { response in
              switch response.result {
              case .success(let movieDetail):
                  completion(.success(movieDetail))
              case .failure(let error):
                  print("Alamofire Decoding Error: \(error)")
                  completion(.failure(error))
              }
          }
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

struct MovieDetail: Decodable {
    let title: String?
    let overview: String?
    let posterPath: String
    let backdropPath: String?
    let releaseDate: String?
    let voteAverage: Double?
    let runtime: Int?
    let genres: [Genre]?
}
struct Genre: Decodable, Hashable {
    let id: Int
    let name: String
}
