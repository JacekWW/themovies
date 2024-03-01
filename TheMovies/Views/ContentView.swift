//
//  ContentView.swift
//  TheMovies
//
//  Created by Jacek Wierzbicki-Wos on 21/02/2024.
//

import Alamofire
import Combine
import SwiftUI

struct ContentView: View {
	@StateObject private var viewModel: MoviesViewModel

	@State private var searchText: String = ""
	@State private var isSearchActive: Bool = false
	@State private var clearSearch: () -> ()

	@State private var cancelablle = Set<AnyCancellable>()

	var body: some View {
		ZStack(alignment: .top) {
			VStack {
				Search(searchText: $searchText,
					   isSearchActive: $isSearchActive,
					   searchResult: $viewModel.searchResult,
					   search: { query in viewModel.fetchSearchResult(for: query)},
					   clearSearch: { clearSearch() })
				.frame(maxHeight: isSearchActive ? .infinity : 48)

				if !isSearchActive {
					ScrollView {
						ForEach(viewModel.movies) { movie in
							HStack {
								MovieItem(movie: movie)
									.frame(height: 160)
								Spacer()
							}
							.padding(.leading, 10)
						}
					}
				} else {
					Spacer()
				}
			}
		}
	}

	init(viewModel: MoviesViewModel) {
		_viewModel = StateObject(wrappedValue: viewModel)
		self.clearSearch = { viewModel.clearSearchResult() }
	}
}

struct MovieItem: View {
	var movie: Movie

	var titleLabel: some View {
		Text("\(movie.title)")
			.font(.headline)
	}

	var yearLabel: some View {
		Text(verbatim: "\(movie.year)")
			.font(.subheadline)
	}

	var directorLabel: some View {
		Text("by \(movie.director)")
			.font(.subheadline)
	}

	var body: some View {
		HStack(alignment: .top) {
			AsyncImage(url: URL(string: movie.poster)) { image in
				image.resizable()
					.aspectRatio(2/3, contentMode: .fit)
			} placeholder: {
				ProgressView()
			}

			VStack(alignment: .leading) {
				titleLabel
				yearLabel
				directorLabel
			}
		}
	}
}

#Preview {
    ContentView(viewModel: MoviesViewModel())
}

