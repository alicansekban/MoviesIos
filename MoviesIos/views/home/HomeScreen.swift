//
//  HomeScreen.swift
//  MoviesIos
//
//  Created by Alican SEKBAN on 25.01.2025.
//

import SwiftUI

struct HomeScreen: View {
    @StateObject private var viewModel: HomeViewModel = .init()
    
    var body: some View {
        VStack {
            List(viewModel.popularMovies, id: \.id) { movie in
            
                Text(movie.title)
            }
        }
    }
}

#Preview {
    HomeScreen()
}
