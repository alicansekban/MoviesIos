//
//  MoviesIosApp.swift
//  MoviesIos
//
//  Created by Alican SEKBAN on 25.01.2025.
//

import SwiftUI
import SwiftData

@main
struct MoviesIosApp: App {
    @StateObject private var router = AppRouter.shared

    var body: some Scene {
        WindowGroup {
            
            NavigationStack(path: $router.path) {
                            // Başlangıç ekranı
                            HomeScreen()
                                // 1. Hedef: Bir Screen enum değeri geldiğinde ne yapılacağını tanımla
                                .navigationDestination(for: AppRouter.Screen.self) { screen in
                                    
                                    
                        switch screen {
                                    case .home:
                                        HomeScreen() // Normalde path'e home eklenmez ama örnek olarak dursun.
                                    case .movieDetail(let movieId):
                                        MovieDetailScreen(movieId: movieId)
                                    }
                                }
                        }
            .environmentObject(router)
        }
    
    }
}
