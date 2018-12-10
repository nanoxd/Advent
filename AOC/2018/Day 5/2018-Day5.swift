extension Year2018 {
    public class Day5: Day {
        let lowercaseLetters = "abcdefghijklmnopqrstuvwxyz"

        public init() { super.init(inputSource: .file(#file)) }
        
        override public func part1() -> String {
            let units = reduceUnits(from: input.trimmed.raw)
            return "\(units.count)"
        }
        
        override public func part2() -> String {
            let uppercasedLetters = lowercaseLetters.uppercased()

            return zip(lowercaseLetters, uppercasedLetters)
                .map { (String($0), String($1) ) }
                .map { input.trimmed.raw.removing($0).removing($1) }
                .map { reduceUnits(from: $0).count }
                .min()!
                .description
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

extension String {
    func removing(_ string: String) -> String {
        return replacingOccurrences(of: string, with: "")
    }
}
