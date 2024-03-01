//
//  MoviesViewModel.swift
//  TheMovies
//
//  Created by Jacek Wierzbicki-Wos on 21/02/2024.
//

import Combine
import Foundation

protocol MoviesViewModelProtocol {
	func fetchSearchResult(for quote: String)
}

class MoviesViewModel: MoviesViewModelProtocol, ObservableObject {
	private var movieRepository: MovieRepositoryProtocol

	private var cancellable = Set<AnyCancellable>()

	@Published var searchResult: [MovieShort]?
	@Published var movies: [Movie] = [
		Movie(
			title: "Iron Man",
			 year: 2008,
			 rated: "PG-13",
			 released: "02 May 2008",
			 runtime: "126 min",
			 genre: "Action, Adventure, Sci-Fi",
			 director: "Jon Favreau",
			 writer: "Mark Fergus, Hawk Ostby, Art Marcum",
			 actors: "Robert Downey Jr., Gwyneth Paltrow, Terrence Howard",
			 plot: "After being held captive in an Afghan cave, billionaire engineer Tony Stark creates a unique weaponized suit of armor to fight evil.",
			 language: "English, Persian, Urdu, Arabic, Kurdish, Hindi, Hungarian",
			 country: "United States, Canada",
			 awards: "Nominated for 2 Oscars. 23 wins & 73 nominations total",
			 poster: "https://m.media-amazon.com/images/M/MV5BMTczNTI2ODUwOF5BMl5BanBnXkFtZTcwMTU0NTIzMw@@._V1_SX300.jpg",
			 ratings: [
				 Rating(source: "Internet Movie Database", value: "7.9/10"),
				 Rating(source: "Rotten Tomatoes", value: "94%"),
				 Rating(source: "Metacritic", value: "79/100")
			 ],
			 metascore: 79,
			 imdbRating: 7.9,
			 imdbVotes: "1,114,341",
			 imdbID: "tt0371746",
			 type: "movie",
			 dvd: "01 Mar 2013",
			 boxOffice: "$319,034,126",
			 production: "N/A",
			 website: "N/A",
			 response: true),
	   Movie(
		   title: "The Incredible Hulk",
		   year: 2008,
		   rated: "PG-13",
		   released: "13 Jun 2008",
		   runtime: "112 min",
		   genre: "Action, Adventure, Sci-Fi",
		   director: "Louis Leterrier",
		   writer: "Zak Penn, Stan Lee, Jack Kirby",
		   actors: "Edward Norton, Liv Tyler, Tim Roth",
		   plot: "Bruce Banner, a scientist on the run from the U.S. Government, must find a cure for the monster he turns into whenever he loses his temper.",
		   language: "English, Portuguese, Spanish",
		   country: "United States, Canada",
		   awards: "2 wins & 10 nominations",
		   poster: "https://m.media-amazon.com/images/M/MV5BMTUyNzk3MjA1OF5BMl5BanBnXkFtZTcwMTE1Njg2MQ@@._V1_SX300.jpg",
		   ratings: [
			   Rating(source: "Internet Movie Database", value: "6.6/10"),
			   Rating(source: "Rotten Tomatoes", value: "67%"),
			   Rating(source: "Metacritic", value: "61/100")
		   ],
		   metascore: 61,
		   imdbRating: 6.6,
		   imdbVotes: "519,538",
		   imdbID: "tt0800080",
		   type: "movie",
		   dvd: "12 Feb 2014",
		   boxOffice: "$134,806,913",
		   production: "N/A",
		   website: "N/A",
		   response: true
	   ),
	   Movie(
		   title: "Iron Man 2",
		   year: 2010,
		   rated: "PG-13",
		   released: "07 May 2010",
		   runtime: "124 min",
		   genre: "Action, Sci-Fi",
		   director: "Jon Favreau",
		   writer: "Justin Theroux, Stan Lee, Don Heck",
		   actors: "Robert Downey Jr., Mickey Rourke, Gwyneth Paltrow",
		   plot: "With the world now aware of his identity as Iron Man, Tony Stark must contend with both his declining health and a vengeful mad man with ties to his father's legacy.",
		   language: "English, French, Russian",
		   country: "United States",
		   awards: "Nominated for 1 Oscar. 7 wins & 45 nominations total",
		   poster: "https://m.media-amazon.com/images/M/MV5BZGVkNDAyM2EtYzYxYy00ZWUxLTgwMjgtY2VmODE5OTk3N2M5XkEyXkFqcGdeQXVyNTgzMDMzMTg@._V1_SX300.jpg",
		   ratings: [
			   Rating(source: "Internet Movie Database", value: "6.9/10"),
			   Rating(source: "Rotten Tomatoes", value: "72%"),
			   Rating(source: "Metacritic", value: "57/100")
		   ],
		   metascore: 57,
		   imdbRating: 6.9,
		   imdbVotes: "861,887",
		   imdbID: "tt1228705",
		   type: "movie",
		   dvd: "03 May 2013",
		   boxOffice: "$312,433,331",
		   production: "N/A",
		   website: "N/A",
		   response: true
	   ),
	   Movie(
		   title: "Thor",
		   year: 2011,
		   rated: "PG-13",
		   released: "06 May 2011",
		   runtime: "115 min",
		   genre: "Action, Fantasy",
		   director: "Kenneth Branagh",
		   writer: "Ashley Miller, Zack Stentz, Don Payne",
		   actors: "Chris Hemsworth, Anthony Hopkins, Natalie Portman",
		   plot: "The powerful but arrogant god Thor is cast out of Asgard to live amongst humans in Midgard (Earth), where he soon becomes one of their finest defenders.",
		   language: "English",
		   country: "United States",
		   awards: "5 wins & 30 nominations",
		   poster: "https://m.media-amazon.com/images/M/MV5BOGE4NzU1YTAtNzA3Mi00ZTA2LTg2YmYtMDJmMThiMjlkYjg2XkEyXkFqcGdeQXVyNTgzMDMzMTg@._V1_SX300.jpg",
		   ratings: [
			   Rating(source: "Internet Movie Database", value: "7.0/10"),
			   Rating(source: "Rotten Tomatoes", value: "77%"),
			   Rating(source: "Metacritic", value: "57/100")
		   ],
		   metascore: 57,
		   imdbRating: 7.0,
		   imdbVotes: "893,302",
		   imdbID: "tt0800369",
		   type: "movie",
		   dvd: "01 Jul 2013",
		   boxOffice: "$181,030,624",
		   production: "N/A",
		   website: "N/A",
		   response: true
	   ),
	   Movie(
		   title: "Captain America: The First Avenger",
		   year: 2011,
		   rated: "PG-13",
		   released: "22 Jul 2011",
		   runtime: "124 min",
		   genre: "Action, Adventure, Sci-Fi",
		   director: "Joe Johnston",
		   writer: "Christopher Markus, Stephen McFeely, Joe Simon",
		   actors: "Chris Evans, Hugo Weaving, Samuel L. Jackson",
		   plot: "Steve Rogers, a rejected military soldier, transforms into Captain America after taking a dose of a \"Super-Soldier serum\". But being Captain America comes at a price as he attempts to take down a warmonger and a terrorist organization.",
		   language: "English, Norwegian, French",
		   country: "United States",
		   awards: "4 wins & 50 nominations",
		   poster: "https://m.media-amazon.com/images/M/MV5BNzAxMjg0NjYtNjNlOS00NTdlLThkMGEtMjAwYjk3NmNkOGFhXkEyXkFqcGdeQXVyNTgzMDMzMTg@._V1_SX300.jpg",
		   ratings: [
			   Rating(source: "Internet Movie Database", value: "6.9/10"),
			   Rating(source: "Rotten Tomatoes", value: "80%"),
			   Rating(source: "Metacritic", value: "66/100")
		   ],
		   metascore: 66,
		   imdbRating: 6.9,
		   imdbVotes: "889,331",
		   imdbID: "tt0458339",
		   type: "movie",
		   dvd: "25 Jul 2013",
		   boxOffice: "$176,654,505",
		   production: "N/A",
		   website: "N/A",
		   response: true
	   ),
	   Movie(
		   title: "The Avengers",
		   year: 2012,
		   rated: "PG-13",
		   released: "04 May 2012",
		   runtime: "143 min",
		   genre: "Action, Sci-Fi",
		   director: "Joss Whedon",
		   writer: "Joss Whedon, Zak Penn",
		   actors: "Robert Downey Jr., Chris Evans, Scarlett Johansson",
		   plot: "Earth's mightiest heroes must come together and learn to fight as a team if they are going to stop the mischievous Loki and his alien army from enslaving humanity.",
		   language: "English, Russian",
		   country: "United States",
		   awards: "Nominated for 1 Oscar. 38 wins & 81 nominations total",
		   poster: "https://m.media-amazon.com/images/M/MV5BNDYxNjQyMjAtNTdiOS00NGYwLWFmNTAtNThmYjU5ZGI2YTI1XkEyXkFqcGdeQXVyMTMxODk2OTU@._V1_SX300.jpg",
		   ratings: [
			   Rating(source: "Internet Movie Database", value: "8.0/10"),
			   Rating(source: "Rotten Tomatoes", value: "91%"),
			   Rating(source: "Metacritic", value: "69/100")
		   ],
		   metascore: 69,
		   imdbRating: 8.0,
		   imdbVotes: "1,449,383",
		   imdbID: "tt0848228",
		   type: "movie",
		   dvd: "22 Jun 2014",
		   boxOffice: "$623,357,910",
		   production: "N/A",
		   website: "N/A",
		   response: true
	   )
	]

	func fetchSearchResult(for quote: String) {
		movieRepository.fetchSearchResult(for: quote)

		movieRepository.searchPublisher
			.sink { [weak self] searchMovies in
				self?.searchResult = searchMovies
			}
			.store(in: &cancellable)
	}

	init(repository: MovieRepositoryProtocol = MoviesRepository()) {
		self.movieRepository = repository
		self.searchResult = []
	}
}
