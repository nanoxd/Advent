import Foundation

/// Allows value introspection using print that returns self
/// Invaluable when debugging transformations
protocol Introspectable {
    func tap(_ identifier: String) -> Self
}

extension Introspectable {
    /// Prints out current value and returns inner value
    func tap(_ identifier: String = "") -> Self {
        Swift.print(identifier, self, "\n")
        return self
    }
}

extension String: Introspectable { }
extension Int: Introspectable { }
extension Array: Introspectable { }
extension Dictionary: Introspectable { }
extension Optional: Introspectable { }
