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
}



extension Sequence where Element: Hashable {
    // Creates a histogram of contents of arrayu
    func histogram() -> [Element: Int] {
        return Dictionary(grouping: self, by: { $0 })
            .mapValues({ $0.count })
    }
}
