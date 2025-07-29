//
//  HomeViewModel.swift
//  MoviesIos
//
//  Created by Alican SEKBAN on 25.01.2025.
//

import SwiftUI
import Combine

class HomeViewModel: ObservableObject {
    @Published var popularMovies: [MovieData] = []
    let dataSource = MoviesDataSource()

    
    init() {
        getPopularMovies()
    }
    
    func getPopularMovies() {

        dataSource.fetchPopularMovies { [weak self ] result in
            guard let self else { return }
            switch result {
            case .success(let movies):
                self.popularMovies = movies
            case .failure(let error):
                print("Error fetching movies: \(error.localizedDescription)")
            }
        }
    }
}
