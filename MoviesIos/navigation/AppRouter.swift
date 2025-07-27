//
//  AppRouter.swift
//  MoviesIos
//
//  Created by Alican SEKBAN on 19.07.2025.
//

import Foundation
import SwiftUI

class AppRouter : ObservableObject {
    @Published var path = [Screen]()

    static let shared = AppRouter()
    private init() {}
    
    
    
    func navigate(to view: some View) {
        
    }
    
    func push(_ screen: Screen) {
           path.append(screen)
    }
       
    
    func pop() {
        if !path.isEmpty {
            path.removeLast()
        }
    }
    
    func popToRoot() {
        path.removeAll()
    }
}
