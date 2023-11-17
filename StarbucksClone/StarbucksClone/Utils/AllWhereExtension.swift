//
//  AllWhereExtension.swift
//  StarbucksClone
//
//  Created by Sarah Crowder on 11/16/23.
//

import Foundation

extension Array where Element: Equatable {
func all(where predicate: (Element) -> Bool) -> [Element] {
    return self.compactMap { predicate($0) ? $0 : nil }
}
}
