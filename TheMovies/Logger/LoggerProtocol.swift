//
//  LoggerProtocol.swift
//  TheMovies
//
//  Created by Jacek Wierzbicki-Wos on 05/03/2024.
//

import Foundation

enum LoggerLevel: String {
	case debug
	case info
	case warning
	case error
}

protocol LoggerProtocol {
	func debug(message: () -> String)
	func info(message: () -> String)
	func warning(message: () -> String, error: Error?)
	func error(message: () -> String, error: Error?)
}
