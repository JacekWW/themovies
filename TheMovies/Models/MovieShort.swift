//
//  MovieShort.swift
//  TheMovies
//
//  Created by Jacek Wierzbicki-Wos on 23/02/2024.
//

import Foundation

struct Search: Decodable {
	let search: [MovieShort]

	private enum CodingKeys: String, CodingKey {
		case search = "Search"
	}
}

struct MovieShort: Decodable {
	let title: String
	let year: String
	let imdbID: String
	let type: String
	let poster: String

	private enum CodingKeys: String, CodingKey {
		case title = "Title"
		case year = "Year"
		case imdbID
		case type = "Type"
		case poster = "Poster"
	}
}
