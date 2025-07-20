//
//  HomeScreen.swift
//  MoviesIos
//
//  Created by Alican SEKBAN on 25.01.2025.
//

import SwiftUI

struct HomeScreen: View {
    @StateObject private var viewModel: HomeViewModel = HomeViewModel()
    @EnvironmentObject var router : AppRouter
    
    var body: some View {
        VStack {
            List(viewModel.popularMovies, id: \.id) { movie in
                Text(movie.title)
                    .onTapGesture {
                        router.push(.movieDetail(id: movie.id))
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
