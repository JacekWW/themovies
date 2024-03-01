//
//  Search.swift
//  TheMovies
//
//  Created by Jacek Wierzbicki-Wos on 27/02/2024.
//

import SwiftUI

struct Search: View {
	@Binding var searchText: String
	@Binding var isSearchActive: Bool
	@Binding var searchResult: [MovieShort]?

	var search: (String) -> ()
	var clearSearch: () -> ()

	@FocusState private var isEditing: Bool

    var body: some View {
			VStack {
				HStack {

					if isSearchActive {
						
						SearchButton()

						TextField(
							"enter phrase to search",
							text: $searchText)
						.padding(.leading, 8)
						.overlay(
							RoundedRectangle(cornerRadius: 8)
								.stroke(.blue, lineWidth: 2)
								.frame(height: 38)
								.padding(.trailing, -20)
						)
						.overlay(
							Image(systemName: "xmark.circle.fill")
								.resizable()
								.scaledToFit()
								.frame(width: 24, height: 24)
								.foregroundColor(.blue)
								.position(x: 270, y: 12)
								.onTapGesture {
									searchText = ""
									clearSearch()
								}
						)
						.focused($isEditing)
						.onSubmit {
							isEditing.toggle()
							search(searchText)
						}

						Button {
							isSearchActive = false
							clearSearch()
							searchText = ""
						} label: {
							Text("Cancel")
								.padding(.leading, 16)
						}

					} else {

						Spacer()

						SearchButton()
							.onTapGesture {
								isSearchActive = true
								isEditing = true
							}
					}
				}

				if let searchResult = searchResult {
					if isSearchActive && !searchResult.isEmpty {
						ScrollView {
							ForEach(searchResult) { movie in
								HStack {
									SearchMovieShortItem(movie: movie)
										.frame(height: 160)
									Spacer()
								}
								.padding(.leading, 10)
							}
						}
						.padding(.bottom, 0)
					}
				}
				Spacer()
		}
    }

	init(searchText: Binding<String>,
		 isSearchActive: Binding<Bool>,
		 searchResult: Binding<[MovieShort]?>,
		 search: @escaping (String) -> (),
		 clearSearch: @escaping () -> ()) {
		self._searchText = searchText
		self._isSearchActive = isSearchActive
		self._searchResult = searchResult
		self.search = search
		self.clearSearch = clearSearch
	}
}

struct SearchMovieShortItem: View {
	var movie: MovieShort

	var body: some View {
		HStack(alignment: .top) {
			AsyncImage(url: URL(string: movie.poster)) { image in
				image.resizable()
					.aspectRatio(2/3, contentMode: .fit)
			} placeholder: {
				ProgressView()
			}

			VStack(alignment: .leading) {
				Text("\(movie.title)")
					.font(.headline)
				Text("\(movie.year)")
					.font(.subheadline)
			}
		}
	}
}

struct Search_Previews: PreviewProvider {
	static var previews: some View {
		@State var isSearchActive: Bool = false
		@State var searchText: String = ""
		@State var searchResults: [MovieShort]? = MovieShortMock().searchResults

		Search(searchText: $searchText,
			   isSearchActive: $isSearchActive,
			   searchResult: $searchResults,
			   search: { _ in },
			   clearSearch: { })

//		Search(searchText: "",
//			   isSearchActive: false,
//			   searchResult: [])
	}
}
