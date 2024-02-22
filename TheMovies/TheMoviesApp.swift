//
//  TheMoviesApp.swift
//  TheMovies
//
//  Created by Jacek Wierzbicki-Wos on 21/02/2024.
//

import SwiftUI

@main
struct TheMoviesApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: MoviesViewModel())
        }
    }
}
