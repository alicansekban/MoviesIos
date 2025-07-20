//
//  AppRouterScreens.swift
//  MoviesIos
//
//  Created by Alican SEKBAN on 20.07.2025.
//

import Foundation
import SwiftUI

extension AppRouter {
    
    enum Screen: Hashable {
        case home
        case movieDetail(id: Int)
        
        @ViewBuilder
        var view: some View {
            switch self {
            case .home:
                HomeScreen()
            case let .movieDetail(id):
                MovieDetailScreen(movieId: id)
            }
        }
    }

}
