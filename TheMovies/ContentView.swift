//
//  ContentView.swift
//  TheMovies
//
//  Created by Jacek Wierzbicki-Wos on 21/02/2024.
//

import AlamofireImage
import SwiftUI

struct ContentView: View {
	@ObservedObject private var viewModel: MoviesViewModel
	@State private var searchText: String = ""
	@State private var isSearchOn: Bool = false
	
	var body: some View {
		VStack {
			SearchViewContainer(searchText: $searchText, isSearchOn: $isSearchOn)
			HStack {
				Text("Movies")
					.font(.title)
					.frame(alignment: .leading)
					.padding(.leading, 20)
				Spacer()
			}
			List {
				ForEach(viewModel.movies) { movie in
					MovieListItem(movie: movie)
						.frame(width: 400, height: 140)
				}
			}
		}
		.onTapGesture {
			isSearchOn = false
		}
	}

	init(viewModel: MoviesViewModel) {
		self.viewModel = viewModel
	}
}

struct MovieListItem: View {
	@State private var movie: Movie

	var body: some View {
		ZStack {
			RoundedRectangle(cornerRadius: 20.0, style: .circular)
				.padding([.leading, .trailing], 25)
				.foregroundColor(Color.gray)
				.ignoresSafeArea(.all)
			HStack {
				AsyncImage(url: URL(string: "\(movie.poster)"), content: { image in
					image
						.resizable()
						.scaledToFit()
						.frame(width: 130, height: 140)
				}, placeholder: {
					ProgressView()
				})

				VStack(alignment: .leading) {
					Text("\(movie.title)")
						.font(.title)
						.frame(width: 230, alignment: .leading)
						.padding(.leading, 0)
					Text(verbatim: "\(movie.year)")
					Spacer()
				}
				.frame(maxWidth: 232)
				Spacer()
			}
		}
	}

	init(movie: Movie) {
		self.movie = movie
	}
}

struct SearchViewContainer: View {
	@Binding var searchText: String
	@Binding var isSearchOn: Bool
	@FocusState var isFocused: Bool

	var body: some View {
		if isSearchOn {
			HStack {
				Image(systemName: "magnifyingglass")
					.frame(width: 20, height: 20, alignment: .leading)
					.padding(.leading, 20)
					.onTapGesture {
						isSearchOn = !isSearchOn
					}
				TextField(
					"enter phrase to search",
					text: $searchText)
				.border(.gray, width: 1)
				.padding(.trailing, 20)
				.onAppear {
					isFocused = true
				}
				.focused($isFocused)
			}
		} else {
			HStack {
				Spacer()
				Image(systemName: "magnifyingglass")
					.frame(width: 20, height: 20, alignment: .trailing)
					.padding(.trailing, 20)
					.onTapGesture {
						isSearchOn = !isSearchOn
					}
			}
		}
	}

}

#Preview {
    ContentView(viewModel: MoviesViewModel())
}
