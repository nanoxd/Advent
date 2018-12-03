import Foundation

/// Measures a closure
///
/// - Parameters:
///   - name: Name of timed block
///   - closures: Closure that is timed
/// - Returns: The output of the block
@discardableResult
func measure<A>(name: String = "", _ closure: () -> A) -> A {
    let startTime = CACurrentMediaTime()
    let result = closure()
    let timeElapsed = CACurrentMediaTime() - startTime

    print("⏱: \(name) - \(timeElapsed)")

    return result
}
