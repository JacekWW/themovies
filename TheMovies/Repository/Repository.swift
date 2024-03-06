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
	private let logger: LoggerProtocol

	public let searchPublisher = PassthroughSubject<[MovieShort], Never>()
	var cancellable = Set<AnyCancellable>()

	required init(networkServce: NetworkProtocol = NetworkService(),
				  logger: LoggerProtocol = AppLogger(logLevel: .debug,
													 category: "repository")) {
		self.networkService = networkServce
		self.logger = logger
	}

	func fetchSearchResult(for quote: String) {
		networkService.fetchSearchResult(for: quote)
			.sink { completion in
				switch completion {
					case .finished:
						self.logger.debug {
							"fetchSearchResult finished"
						}
					case .failure(let error):
						self.logger.error {
							"fetchSearchResult finished with \(error)"
						}
				}
			} receiveValue: { [weak self] searchResult in
				self?.searchPublisher
					.send(searchResult.search)
			}
			.store(in: &cancellable)
	}
}
