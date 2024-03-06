//
//  AppLogger.swift
//  TheMovies
//
//  Created by Jacek Wierzbicki-Wos on 05/03/2024.
//

import OSLog

class AppLogger: LoggerProtocol {
	private let logLevel: LoggerLevel
	private let logger: Logger

	func debug(message: @autoclosure () -> String) {
		guard logLevel.rawValue >= LoggerLevel.debug.rawValue else { return }
		
		let message = message()
		
		logger.log(level: .debug, "\(message, privacy: .public)")
	}
	
	func info(message: @autoclosure () -> String) {
		guard logLevel.rawValue >= LoggerLevel.info.rawValue else { return }
		
		let message = message()
		
		logger.log(level: .info, "\(message, privacy: .public)")
	}

	func warning(message: @autoclosure () -> String, error: Error? = nil) {
		guard logLevel.rawValue >= LoggerLevel.warning.rawValue else { return }
		
		let message = message()
		
		if let error = error {
			logger.warning("\(message, privacy: .public) error: \(error)")
		} else {
			logger.warning("\(message, privacy: .public)")
		}
	}

	func error(message: @autoclosure () -> String, error: Error? = nil) {
		guard logLevel.rawValue >= LoggerLevel.error.rawValue else { return }
		
		let message = message()
		
		if let error = error {
			logger.error("\(message, privacy: .public) error: \(error)")
		} else {
			logger.error("\(message, privacy: .public)")
		}
	}

	init(logLevel: LoggerLevel = .debug,
		 subsystem: String = Bundle.main.bundleIdentifier!,
		 category: String) {
		self.logLevel = logLevel
		self.logger = Logger(subsystem: subsystem, category: category)
	}
}

extension LoggerProtocol {
	func warning(message: @autoclosure () -> String, error: Error? = nil) {
		self.warning(message: message(), error: error)
	}

	func error(message: @autoclosure () -> String, error: Error? = nil) {
		self.error(message: message(), error: error)
	}
}
