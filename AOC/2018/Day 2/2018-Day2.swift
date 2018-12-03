extension Year2018 {
    public class Day2: Day {
        public init() { super.init(inputSource: .file(#file)) }

        //        For example, if you see the following box IDs:
        //
        //        abcdef contains no letters that appear exactly two or three times.
        //        bababc contains two a and three b, so it counts for both.
        //        abbcde contains two b, but no letter appears exactly three times.
        //        abcccd contains three c, but no letter appears exactly two times.
        //        aabcdd contains two a and two d, but it only counts once.
        //        abcdee contains two e.
        //        ababab contains three a and three b, but it only counts once.
        //
        //        Of these box IDs, four of them contain a letter which appears exactly twice, and three of them contain a letter which appears exactly three times. Multiplying these together produces a checksum of 4 * 3 = 12.
        //
        //        What is the checksum for your list of box IDs?
        public override func part1() -> String {
            let ids = input.trimmed.lines.characters
            let idCounts = Array(ids
                .lazy
                .map { $0.histogram }
                .map { histogram in
                    return histogram
                        .filter { $0.value == 2 || $0.value == 3 }
                        .map { $0.value }
                        .unique
                }
                .reduce(into: []) { acc, checksum in
                    acc.append(contentsOf: checksum)
                })
                .histogram

            let checksum = idCounts
                .reduce(into: 1) { acc, count in
                    acc *= count.value
            }

            return String(checksum)
        }
        
        override public func part2() -> String {
            return ""
        }
    }
}
