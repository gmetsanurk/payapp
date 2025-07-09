//
//  Logger.swift
//  payapp
//
//  Created by Georgy on 2025-07-07.
//

final class Logger {
    enum Level: String {
        case error
        case verbose
    }

    static func log(_ level: Level, _ message: String) {
        print("\(level.rawValue.uppercased()): \(message)")
    }
}
