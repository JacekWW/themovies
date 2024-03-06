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
	func debug(message: @autoclosure () -> String)
	func info(message: @autoclosure () -> String)
	func warning(message: @autoclosure () -> String, error: Error?)
	func error(message: @autoclosure () -> String, error: Error?)
}
