import Foundation

extension Year2018 {
    public class Day1: Day {
        public init() { super.init(inputSource: .file(#file)) }

        public override func part1() -> String {
            let sum = input.trimmed.lines.integers.reduce(0, +)
            return String(sum)
        }

        public override func part2() -> String {
            return ""
        }
    }
}
