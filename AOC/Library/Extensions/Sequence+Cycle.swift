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
