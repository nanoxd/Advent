import Foundation

extension Year2018 {
    public class Day1: Day {
        public init() { super.init(inputSource: .file(#file)) }

        public override func part1() -> String {
            let sum = input.trimmed.lines.integers.reduce(0, +)
            return String(sum)
        }

        public override func part2() -> String {
            let frequencies = input.trimmed.lines.integers
            var current = 0
            var seen: Set<Int> = [0]

            for frequency in frequencies.cycled {
                current += frequency

                if seen.contains(current) {
                    break
                }

                seen.insert(current)
            }

            return String(current)
        }
    }
}
