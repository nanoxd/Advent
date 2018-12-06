
fileprivate let dateFormatter: DateFormatter = {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "y-MM-dd HH:mm"
    dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)

    return dateFormatter
}()

struct Entry: CustomStringConvertible {
    fileprivate static let logEntryRegex =
        Regex(pattern: "\\[(\\d{4}-\\d{2}-\\d{2} \\d{2}:\\d{2})\\] (.+)")
    fileprivate static let shiftBeganRegex =
        Regex(pattern: "Guard #(\\d+) begins shift")

    let date: Date

    private let rawEntry: String
    let entry: EntryType

    enum EntryType {
        case wakesUp
        case fallsAsleep
        case shiftBegan(number: Int)

        init(entry: String) {
            switch entry {
            case "wakes up":
                self = .wakesUp
            case "falls asleep":
                self = .fallsAsleep
            default:
                let matches = Entry.shiftBeganRegex.match(entry)!.matches
                self = .shiftBegan(number: Int(matches[1])!)
            }
        }
    }

    init?(from string: String) {
        guard let matches = type(of: self).logEntryRegex.match(string)?.matches else {
            return nil
        }

        self.date = dateFormatter.date(from: matches[1])!
        self.rawEntry = matches[2]

        self.entry = .init(entry: rawEntry)
    }

    var description: String {
        return """
        \(date) - \(rawEntry)\n
        """
    }
}

extension Entry: Comparable {
    static func < (lhs: Entry, rhs: Entry) -> Bool {
        return lhs.date < rhs.date
    }

    static func == (lhs: Entry, rhs: Entry) -> Bool {
        return lhs.date == rhs.date && lhs.rawEntry == rhs.rawEntry
    }
}

extension Year2018 {
    public class Day4: Day {
        lazy var entries: [Entry] = {
            return input.trimmed.rawLines
                .compactMap { Entry(from: $0) }
                .sorted()
        }()

        public init() { super.init(inputSource: .file(#file)) }
        
        override public func part1() -> String {
            let clumpedEntries = entries
                .reduce(into: [[Entry]]()) { acc, entry in
                    switch entry.entry {
                    case let .shiftBegan(number):
                        acc.append([entry])
                    case .wakesUp, .fallsAsleep:
                        acc[acc.endIndex - 1].append(entry)
                    }
            }

            return "\(clumpedEntries)"
        }
        
        override public func part2() -> String {
            return ""
        }
    }
}
