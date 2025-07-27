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
    
    func fetchMovieDetail(movieId: Int, completion: @escaping (Result<MovieDetail, Error>) -> Void) {
            
            // 1. Temel URL'i oluştur.
        guard var url = URL(string: baseURL) else {
                completion(.failure(NSError(domain: "Invalid Base URL", code: 400, userInfo: nil)))
                return
            }
            
            // 2. Path'e gerekli bileşenleri ekle. Bu, en önemli kısım.
            // /movie/{movieId} yolunu oluşturuyoruz.
            url.appendPathComponent("movie")
            url.appendPathComponent("\(movieId)")
            
            print("Generated Detail URL: \(url)")
            
            // 3. Request'i hazırla (Popüler filmlerle aynı mantık).
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
            
            // 4. URLSession ile isteği gönder.
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                // Gelen yanıtı ana thread'de işlemek genellikle daha güvenlidir,
                // özellikle UI güncellemeleri yapılacaksa.
                DispatchQueue.main.async {
                    if let error = error {
                        completion(.failure(error))
                        return
                    }
                    
                    guard let data = data else {
                        completion(.failure(NSError(domain: "No Data", code: 500, userInfo: nil)))
                        return
                    }
                    
                    // 5. Gelen datayı MovieDetail modeline decode et.
                    do {
                        let decoder = JSONDecoder()
                        // JSON'daki snake_case (örn: release_date) anahtarlarını
                        // Swift'teki camelCase (örn: releaseDate) özelliklerine dönüştür.
                        decoder.keyDecodingStrategy = .convertFromSnakeCase
                        
                        let decodedResponse = try decoder.decode(MovieDetail.self, from: data)
                        completion(.success(decodedResponse))
                    } catch {
                        print("JSON Decoding Error: \(error)")
                        completion(.failure(error))
                    }
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

struct MovieDetail: Decodable {
    let title: String?
    let overview: String?
    let posterPath: String?      // Bazen null gelebilir, bu yüzden Optional (?)
    let backdropPath: String?    // Bu da null gelebilir
    let releaseDate: String?
    let voteAverage: Double?
    let runtime: Int?
    let genres: [Genre]?
}

// JSON içindeki "genres" dizisindeki her bir objeyi temsil eder.
struct Genre: Decodable, Hashable {
    let id: Int
    let name: String
}
