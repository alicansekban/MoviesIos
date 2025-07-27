//
//  MovieDetailViewModel.swift
//  MoviesIos
//
//  Created by Alican SEKBAN on 25.01.2025.
//

import Foundation
class MovieDetailViewModel : ObservableObject {
    let dataSource = MoviesDataSource()
    @Published var movieDetail: MovieDetail?
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    var movieId : Int?
    
    init(movieId: Int? = nil) {
        self.movieId = movieId
    }
    
    func getMovieDetail() {
        guard let movieId = movieId else { return }
        dataSource.fetchMovieDetail(movieId: movieId) { [weak self] result in
            switch result {
            case .success(let movieDetail):
                self?.movieDetail = movieDetail
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
}
