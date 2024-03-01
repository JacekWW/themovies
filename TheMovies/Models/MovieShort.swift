//
//  MovieShort.swift
//  TheMovies
//
//  Created by Jacek Wierzbicki-Wos on 23/02/2024.
//

import Foundation

struct SearchResult: Decodable {
	let search: [MovieShort]

	private enum CodingKeys: String, CodingKey {
		case search = "Search"
	}
}

struct MovieShort: Decodable, Identifiable {
	var id: String { imdbID }
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

struct MovieShortMock {
	var searchResults: [MovieShort] = [
		MovieShort(
			title: "Iron Man",
			year: "2008",
			imdbID: "tt0371746",
			type: "movie",
			poster: "https://m.media-amazon.com/images/M/MV5BMTczNTI2ODUwOF5BMl5BanBnXkFtZTcwMTU0NTIzMw@@._V1_SX300.jpg"
		),
		MovieShort(
			title: "Iron Man 3",
			year: "2013",
			imdbID: "tt1300854",
			type: "movie",
			poster: "https://m.media-amazon.com/images/M/MV5BMjE5MzcyNjk1M15BMl5BanBnXkFtZTcwMjQ4MjcxOQ@@._V1_SX300.jpg"
		),
		MovieShort(
			title: "Iron Man 2",
			year: "2010",
			imdbID: "tt1228705",
			type: "movie",
			poster: "https://m.media-amazon.com/images/M/MV5BZGVkNDAyM2EtYzYxYy00ZWUxLTgwMjgtY2VmODE5OTk3N2M5XkEyXkFqcGdeQXVyNTgzMDMzMTg@._V1_SX300.jpg"
		),
		MovieShort(
			title: "The Man in the Iron Mask",
			year: "1998",
			imdbID: "tt0120744",
			type: "movie",
			poster: "https://m.media-amazon.com/images/M/MV5BZjM2YzcxMmQtOTc2Mi00YjdhLWFlZjUtNmFmMDQzYzU2YTk5L2ltYWdlXkEyXkFqcGdeQXVyNTAyODkwOQ@@._V1_SX300.jpg"
		),
		MovieShort(
			title: "The Man with the Iron Fists",
			year: "2012",
			imdbID: "tt1258972",
			type: "movie",
			poster: "https://m.media-amazon.com/images/M/MV5BMTg5ODI3ODkzOV5BMl5BanBnXkFtZTcwMTQxNjUwOA@@._V1_SX300.jpg"
		)
	]
}
