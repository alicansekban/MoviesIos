//
//  HomeScreen.swift
//  MoviesIos
//
//  Created by Alican SEKBAN on 25.01.2025.
//

import SwiftUI

struct HomeScreen: View {
    @StateObject private var viewModel: HomeViewModel = HomeViewModel()
    
    var body: some View {
        VStack {
            List(viewModel.popularMovies, id: \.id) { movie in
                Text(movie.title)
                    .onTapGesture {
                        
                    }
            }
        }
        .onAppear {
            viewModel.getPopularMovies()
        }
    }
}

#Preview {
    HomeScreen()
}
