//
//  MovieDetailViewModel.swift
//  MoviesIos
//
//  Created by Alican SEKBAN on 25.01.2025.
//

import Foundation
class MovieDetailViewModel : ObservableObject {
    
    var movieId : Int?
    init(movieId: Int? = nil) {
        self.movieId = movieId
    }
}
