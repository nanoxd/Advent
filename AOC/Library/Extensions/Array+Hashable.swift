import Foundation

extension Array where Element: Hashable {

    /// Provides a histogram of the contents of the Array
    var histogram: [Element: Int] {
        return reduce(into: [:]) { counts, elem in
            counts[elem, default: 0] += 1
        }
    }
    
    var unique: [Element] {
        return Array(Set(self))
    }
}
