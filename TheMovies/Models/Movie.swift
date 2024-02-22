//
//  Movie.swift
//  TheMovies
//
//  Created by Jacek Wierzbicki-Wos on 21/02/2024.
//

import Foundation

struct Movie: Decodable, Identifiable {
	var id: String = UUID().uuidString

	let title: String
	let year: Int
	let rated: String
	let released: String
	let runtime: String
	let genre: String
	let director: String
	let writer: String
	let actors: String
	let plot: String
	let language: String
	let country: String
	let awards: String
	let poster: String
	let ratings: [Rating]
	let metascore: Int
	let imdbRating: Double
	let imdbVotes: String
	let imdbID: String
	let type: String
	let dvd: String
	let boxOffice: String
	let production: String
	let website: String
	let response: Bool
	
	private enum CodingKeys: String, CodingKey {
		case title = "Title"
		case year = "Year"
		case rated = "Rated"
		case released = "Released"
		case runtime = "Runtime"
		case genre = "Genre"
		case director = "Director"
		case writer = "Writer"
		case actors = "Actors"
		case plot = "Plot"
		case language = "Language"
		case country = "Country"
		case awards = "Awards"
		case poster = "Poster"
		case ratings = "Ratings"
		case metascore = "Metascore"
		case imdbRating
		case imdbVotes
		case imdbID
		case type = "Type"
		case dvd = "DVD"
		case boxOffice = "BoxOffice"
		case production = "Production"
		case website = "Website"
		case response = "Response"
	}
}

struct Rating: Decodable {
	let source: String
	let value: String
	
	private enum CodingKeys: String, CodingKey {
		case source = "Source"
		case value = "Value"
	}
}
