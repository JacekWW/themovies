//
//  SearchButton.swift
//  TheMovies
//
//  Created by Jacek Wierzbicki-Wos on 27/02/2024.
//

import SwiftUI

struct SearchButton: View {
    var body: some View {
		Image(systemName: "magnifyingglass")
			.resizable()
			.scaledToFit()
			.padding(8)
			.frame(width: 40, height: 40)
			.foregroundColor(.blue)
    }
}

#Preview {
    SearchButton()
}
