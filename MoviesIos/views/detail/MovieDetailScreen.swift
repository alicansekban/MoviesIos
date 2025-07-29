//
//  MovieDetailScreen.swift
//  MoviesIos
//
//  Created by Alican SEKBAN on 25.01.2025.
//

import SwiftUI

struct MovieDetailScreen: View {
    @StateObject var viewModel: MovieDetailViewModel = MovieDetailViewModel()
    private let imageBaseURL = "https://image.tmdb.org/t/p/w500"
    
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
                      VStack(alignment: .leading, spacing: 16) {
                          
                          let imageUrl = URL(string: imageBaseURL + detail.posterPath)
                          AsyncImage(url: imageUrl) { image in
                                 
                                 image
                                     .resizable()
                                     .scaledToFill()
                                                          
                             } placeholder: {
                                 ProgressView()
                                     .frame(maxWidth: .infinity, minHeight: 250) // Örnek bir yükseklik
                             }
                             .frame(height: 400)
                             .cornerRadius(20)
                             .clipped()
                            
                          Text("Summary")
                              .font(.title2)
                              .fontWeight(.semibold)
                              .padding(.bottom, 4)
                          
                          Text(detail.overview ?? "")
                              .font(.body)
                              .fontWeight(.medium)
                          
                        
                          HStack {
                              Image(systemName: "star.fill")
                                  .foregroundColor(.yellow)
                              Text(String(format: "%.1f", detail.voteAverage ?? 0.0))
                             // Spacer().frame(width: 20)
                              Image(systemName: "calendar")
                                  .padding(.leading, 20)
                              Text(detail.releaseDate ?? "")
                                  .font(.subheadline)
                                  .foregroundColor(.secondary)
                           
                          }
                          
                        
                      }
                      .padding()
                  }
            
              }
              
              else {
                  EmptyView()
              }
          }
          .navigationTitle(viewModel.movieDetail?.title ?? "Detail")
      //    .navigationBarTitleDisplayMode(.inline)
          .onAppear {
              viewModel.getMovieDetail()
          }
      }
    
}

#Preview {
    MovieDetailScreen(movieId: 0)
}
