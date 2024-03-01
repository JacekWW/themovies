//
//  Repository.swift
//  TheMovies
//
//  Created by Jacek Wierzbicki-Wos on 26/02/2024.
//

import Combine
import Foundation

protocol MovieRepositoryProtocol {
	var searchPublisher: PassthroughSubject<[MovieShort], Never> { get }

	func fetchSearchResult(for quote: String)
}

class MoviesManager<T: MovieRepositoryProtocol> {
	var moviesRepository: T

	init(repository: T) {
		self.moviesRepository = repository
	}
}

class MoviesRepository: MovieRepositoryProtocol {
	let networkService: NetworkProtocol

	public let searchPublisher = PassthroughSubject<[MovieShort], Never>()
	var cancellable = Set<AnyCancellable>()

	required init(networkServce: NetworkProtocol = NetworkService()) {
		self.networkService = networkServce
	}

	func fetchSearchResult(for quote: String) {
		networkService.fetchSearchResult(for: quote)
			.sink { completion in
				switch completion {
					case .finished:
						print("Search fetch finished")
					case .failure(let error):
						print("Search fetch error:\(error)")
				}
			} receiveValue: { [weak self] searchResult in
				self?.searchPublisher
					.send(searchResult.search)
			}
			.store(in: &cancellable)
	}
}
