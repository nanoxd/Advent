import Foundation

extension String {
    public func distance(to str: String) -> Int {
        return zip(indices, str.indices)
            .count(where: { self[$0] != str[$1] })
    }

    public func intersection(with str: String) -> String {
        return String(
            zip(indices, str.indices)
                .filter { self[$0] == str[$1] }
                .map { self[$0.0] }
        )
    }
}
