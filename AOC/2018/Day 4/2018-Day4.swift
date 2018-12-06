
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

    enum EntryType: Equatable {
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

        var guardID: Int? {
            switch self {
            case let .shiftBegan(number): return number
            default: return nil
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

struct Log: CustomStringConvertible {
    private var entries: [Entry]
    let guardID: Int

    var minutesAsleep: Int {
        let asleep = entries.filter { $0.entry == .fallsAsleep }
        let awake = entries.filter { $0.entry == .wakesUp }

        let timeAsleep = zip(asleep, awake)
            .compactMap { asleep, awake in
                let components = NSCalendar.current
                    .dateComponents([.minute], from: asleep.date, to: awake.date)

                return components.minute
            }
            .reduce(0, +)

        return timeAsleep
    }

    init(guardID: Int, entry: Entry) {
        self.guardID = guardID
        self.entries = [entry]
    }

    mutating func append(_ entry: Entry) {
        entries.append(entry)
    }

    // MARK: CustomStringConvertible

    var description: String {
        return "Guard #\(guardID): Time Asleep: \(minutesAsleep)"
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
            let guardLogs = [Int: [Log]]()
            let clumpedEntries = entries
                .reduce(into: [Log]()) { acc, entry in
                    switch entry.entry {
                    case .shiftBegan(let id):
                        let log = Log(guardID: id, entry: entry)
                        acc.append(log)
                    case .wakesUp, .fallsAsleep:
                        acc[acc.endIndex - 1].append(entry)
                    }
            }
                .reduce(into: guardLogs) { acc, log in
                    if acc[log.guardID] != nil {
                        acc[log.guardID]?.append(log)
                    } else {
                        acc[log.guardID] = [log]
                    }
            }
                .max { log1, log2 in
                    let minutesAsleep1 = log1.value.reduce(into: 0, { $0 + $1.minutesAsleep })
                    let minutesAsleep2 = log2.value.reduce(into: 0, { $0 + $1.minutesAsleep })

                    return minutesAsleep1 > minutesAsleep2
            }

            return "\(clumpedEntries)"
        }
        
        override public func part2() -> String {
            return ""
        }
    }
}
