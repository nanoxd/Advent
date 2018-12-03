import Foundation

extension Sequence {
    /// Infinitely cycles through the current sequence
    var cycled: AnyIterator<Element> {
        var current = makeIterator()

        return AnyIterator {
            guard let result = current.next() else {
                current = self.makeIterator()
                return current.next()
            }

            return result
        }
    }

    func count(where predicate: (Element) throws -> Bool) rethrows -> Int {
        var count = 0
        for element in self {
            if try predicate(element) {
                count += 1
            }
        }
        return count
    }
}



extension Sequence where Element: Hashable {
    // Creates a histogram of contents of arrayu
    func histogram() -> [Element: Int] {
        return Dictionary(grouping: self, by: { $0 })
            .mapValues({ $0.count })
    }
}
