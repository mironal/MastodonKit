import Foundation

extension Requests {
    public enum Bookmarks {
        open class All: RequestBase<[Status]> {
            /// Fetches a user's bookmarks.
            ///
            /// - Parameter range: The bounds used when requesting data from Mastodon.
            public init(range: RequestRange = .default) {
                let parameters = range.parameters(limit: between(1, and: 40, default: 20))
                let method = HTTPMethod.get(.parameters(parameters))
                super.init(path: "/api/v1/bookmarks", method: method)
            }
        }
    }
}
