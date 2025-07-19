//
//  MovieDetailScreen.swift
//  MoviesIos
//
//  Created by Alican SEKBAN on 25.01.2025.
//

import SwiftUI

struct MovieDetailScreen: View {
    @StateObject var viewModel: MovieDetailViewModel = MovieDetailViewModel()
    init(movieId: Int) {
        _viewModel = .init(wrappedValue: MovieDetailViewModel(movieId: movieId))
    }
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    MovieDetailScreen(movieId: 0)
}
