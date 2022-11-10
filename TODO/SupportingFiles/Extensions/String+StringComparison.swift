//
//  String+StringComparison.swift
//  todo
//
//  Created by Иван Тарасенко on 10.11.2022.
//

import Foundation

extension String {

    // A method that compares strings with character ranges
    static func ~= (lhs: String, rhs: String) -> Bool {
        guard let regex = try? NSRegularExpression(pattern: rhs) else { return false }
        let range = NSRange(location: 0, length: lhs.utf16.count)
        return regex.firstMatch(in: lhs, options: [], range: range) != nil
    }
}
