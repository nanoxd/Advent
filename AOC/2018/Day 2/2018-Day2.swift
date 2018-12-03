import Foundation

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
            let ids = input.trimmed.lines.raw

            let counts = ids.map { $0.histogram().values }
            let checksum = counts.count(where: { $0.contains(2) })
                    * counts.count(where: { $0.contains(3) })

            return String(checksum)
        }
        
        override public func part2() -> String {
            let ids = input.trimmed.lines.raw
            return ids
                .compactMap { id in
                    ids
                        .first(where: { id.distance(to: $0) == 1 })
                        .map { (id, $0) }
                }
                .map { $0.intersection(with: $1) }
                .first ?? ""
        }
    }
}
