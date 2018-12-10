extension Year2018 {
    public class Day5: Day {
        public init() { super.init(inputSource: .file(#file)) }
        
        override public func part1() -> String {
            let units = reduceUnits(from: input.trimmed.raw)
            return "\(units.count)"
        }
        
        override public func part2() -> String {
            return ""
        }

        public func reduceUnits(from units: String) -> String {
            return units.reduce(into: "") { (acc, unit) in
                if let lastUnit = acc.last,
                    unit != lastUnit,
                    String(unit).lowercased() == String(lastUnit).lowercased() {
                    acc.removeLast()
                } else {
                    acc.append(unit)
                }
            }
        }
    }
}

