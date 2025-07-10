//
//  String+Extension.swift
//  payapp
//
//  Created by Georgy on 2025-07-10.
//

import Foundation

extension String {
    var localized: String {
        NSLocalizedString(self, comment: "")
    }
}
