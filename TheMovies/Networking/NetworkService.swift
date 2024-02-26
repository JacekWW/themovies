//
//  NetworkService.swift
//  TheMovies
//
//  Created by Jacek Wierzbicki-Wos on 23/02/2024.
//

import Alamofire
import Combine
import Foundation

protocol Networking {

}

class NetworkService: Networking {
	private let sessionManager: Session

	private enum Endpoint {
		static let OMDbAPIKey: String = ProcessInfo.processInfo.environment["OMDbAPIKey"]!
	}

	init(sessionManager: Session = AF) {
		self.sessionManager = sessionManager
	}

	enum OMDbRouter: URLRequestConvertible {
		case search(String)

		var baseURL: URL {
			return URL(string: "https://www.omdbapi.com")!
		}

		var method: HTTPMethod {
			return .get
		}

		var parameters: Parameters {
			switch self {
				case .search(let query):
					return ["s": query]
			}
		}

		var path: String {
			switch self {
				case .search(_):
					return ""
			}
		}

		func asURLRequest() throws -> URLRequest {
			let url = baseURL.appendingPathComponent(path)

			var request = URLRequest(url: url)
			request.method = method
			request.headers = HTTPHeaders()
			request.headers = ["Accept": "application/json",
							   "Content-Type": "application/x-www-form-urlencoded"]

			var allParameters: [String: String] = [:]

			allParameters = parameters.mapValues { "\($0)" }
			allParameters.updateValue(Endpoint.OMDbAPIKey, forKey: "apikey")

			do {
				request = try URLEncodedFormParameterEncoder().encode(allParameters, into: request)
			} catch let error {
				print("Unable to encode parameters. Error:\(error)")
			}

			return request
		}
	}

	func fetchSearchResult(for query: String) -> AnyPublisher<Search, Alamofire.AFError> {
		let future = Future<Search, AFError> { [weak self] promise in
			self?.sessionManager.request(OMDbRouter.search(query))
				.validate()
				.responseDecodable(of: Search.self) { response in
					switch response.result {
						case .success(let searchResult):
							promise(.success(searchResult))
						case .failure(let error):
							promise(.failure(error))
					}
				}
		}

		return AnyPublisher(future)
	}
}
