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
          ZStack {
              if viewModel.isLoading {
                  ProgressView("Loading...")
              }
              else if let errorMessage = viewModel.errorMessage {
                  Text(errorMessage)
                      .foregroundColor(.red)
                      .padding()
              }
            
              else if let detail = viewModel.movieDetail {
                
                  ScrollView {
                      VStack(alignment: .leading) {
                          Text(detail.title ?? "")
                              .font(.largeTitle)
                              .fontWeight(.bold)
                          
                          Text(detail.overview ?? "")
                              .padding(.top, 4)
                          
                        
                      }
                      .padding()
                  }
              }
              
              else {
                  EmptyView()
              }
          }
          .navigationTitle(viewModel.movieDetail?.title ?? "Detay")
          .onAppear {
              viewModel.getMovieDetail()
          }
      }
    
}

#Preview {
    MovieDetailScreen(movieId: 0)
}
