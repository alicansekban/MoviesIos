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
       
       // Son ekranı yığından çıkarır (pop).
       func pop() {
           // Kontrol eklemek her zaman iyidir.
           if !path.isEmpty {
               path.removeLast()
           }
       }
       
       // Tüm yığını temizleyip ana ekrana döner (pop to root).
       func popToRoot() {
           path.removeAll()
       }
}
