import CoreGraphics.CGGeometry

extension Year2018 {
    public class Day3: Day {
        let regex = Regex(pattern: "#(\\d+) @ (\\d+),(\\d+): (\\d+)x(\\d+)")

        lazy var claims: [CGRect] = {
            return input.trimmed.lines.raw
                .compactMap { line in
                    guard let matches = regex.match(line)?.matches else {
                        return nil
                    }

                    let match = matches.dropFirst().compactMap { Int($0) }

                    return CGRect(
                        x: match[1],
                        y: match[2],
                        width: match[3],
                        height: match[4]
                    )
            }
        }()

        public init() { super.init(inputSource: .file(#file)) }
        
        override public func part1() -> String {
            return String(
                claims.flatMap { rect1 in
                    return claims
                        .filter { $0 != rect1 }
                        .flatMap { rect2 in
                            rect1.points(intersecting: rect2)
                                .map { $0.debugDescription }
                    }
                    }
                    .unique
                    .count
            )
        }
        
        override public func part2() -> String {
            return String(
                claims
                    .map { claim in
                        claims
                            .filter { $0 != claim }
                            .first { $0.intersects(claim) }}
                    .firstIndex { $0 == nil }
                    .map { $0 + 1 } ?? 0
            )
        }
    }
}

extension CGRect {
    func points(intersecting rect2: CGRect) -> [CGPoint] {
        guard intersects(rect2) else {
            return []
        }

        let intersectRect = intersection(rect2)
        let xRange = convertToRange(
            starting: intersectRect.minX,
            ending: intersectRect.maxX
        )

        let yRange = convertToRange(
            starting: intersectRect.minY,
            ending: intersectRect.maxY
        )
        return xRange
            .flatMap { x in
                yRange.map { y in
                    return CGPoint(x: x, y: y)
                }
        }
    }

}

func convertToRange(starting x: CGFloat, ending y: CGFloat) -> Range<Int> {
    return (Int(x)..<Int(y))
}
