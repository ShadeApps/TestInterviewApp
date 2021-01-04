//
//  Collcetion.swift
//  TestInterviewApp
//
//  Created by Sergey Grischyov on 05.01.2021.
//

import Foundation

extension Collection {

    subscript(safe index: Index) -> Iterator.Element? {
        guard indices.contains(index) else {
            return nil
        }
        return self[index]
    }
}

extension Array {

    var middle: Element? {
        guard !isEmpty else { return nil }

        let middleIndex = (count > 1 ? count - 1 : count) / 2
        return self[middleIndex]
    }

    func optional(_ index: Index) -> Element? {
        return index < count && index >= 0 ? self[index] : nil
    }

}
