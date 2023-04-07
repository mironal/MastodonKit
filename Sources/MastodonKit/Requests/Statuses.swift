//
//  Statuses.swift
//  MastodonKit
//
//  Created by Ornithologist Coder on 4/9/17.
//  Copyright © 2017 MastodonKit. All rights reserved.
//

import Foundation

extension Requests {
    /// `Statuses` requests.
    public enum Statuses {
        /// Fetches a status.
        open class StatusBy: RequestBase<Status> {
            /// - Parameter id: The status id.
            public init(id: String) {
                super.init(path: "/api/v1/statuses/\(id)")
            }
        }

        /// Gets a status context.
        open class ContextBy: RequestBase<Context> {
            /// - Parameter id: The status id.
            public init(id: String) {
                super.init(path: "/api/v1/statuses/\(id)/context")
            }
        }

        /// Gets a card associated with a status.
        open class CardBy: RequestBase<Card> {

            /// - Parameter id: The status id.
            public init(id: String) {
                super.init(path: "/api/v1/statuses/\(id)/card")
            }
        }

        /// Gets who reblogged a status.
        open class RebloggedBy: RequestBase<[Account]> {
            /// - Parameters:
            ///   - id: The status id.
            ///   - range: The bounds used when requesting data from Mastodon.
            public init(id: String, range: RequestRange = .default) {
                let parameters = range.parameters(limit: between(1, and: 80, default: 40))
                super.init(path: "/api/v1/statuses/\(id)/reblogged_by", method: .get(.parameters(parameters)))
            }
        }

        /// Gets who favourited a status.
        open class FavouritedBy: RequestBase<[Account]> {
            /// - Parameters:
            ///   - id: The status id.
            ///   - range: The bounds used when requesting data from Mastodon.
            public init(id: String, range: RequestRange = .default) {
                let parameters = range.parameters(limit: between(1, and: 80, default: 40))
                super.init(path: "/api/v1/statuses/\(id)/favourited_by", method: .get(.parameters(parameters)))
            }
        }

        /// Posts a new status.
        open class Create: RequestBase<Status> {
            /// - Parameters:
            ///   - status: The text of the status.
            ///   - replyTo: The local ID of the status you want to reply to.
            ///   - mediaIDs: The array of media IDs to attach to the status (maximum 4).
            ///   - sensitive: Marks the status as NSFW.
            ///   - spoilerText: the text to be shown as a warning before the actual content.
            ///   - visibility: The status' visibility.
            public init(status: String,
                        replyToID: String? = nil,
                        mediaIDs: [String] = [],
                        sensitive: Bool? = nil,
                        spoilerText: String? = nil,
                        visibility: Visibility = .public) {
                let parameters = [
                    Parameter(name: "status", value: status),
                    Parameter(name: "in_reply_to_id", value: replyToID),
                    Parameter(name: "sensitive", value: sensitive.flatMap(trueOrNil)),
                    Parameter(name: "spoiler_text", value: spoilerText),
                    Parameter(name: "visibility", value: visibility.rawValue)
                ] + mediaIDs.map(toArrayOfParameters(withName: "media_ids"))
                super.init(path: "/api/v1/statuses", method: .post(.parameters(parameters)))
            }
        }

        /// Deletes a status.
        open class Delete: RequestBase<Empty> {
            /// - Parameter id: The status id.
            public init(id: String) {
                super.init(path: "/api/v1/statuses/\(id)", method: .delete(.empty))
            }
        }

        /// Reblogs a status.
        open class Reblog: RequestBase<Status> {
            /// - Parameter id: The status id.
            public init(id: String) {
                super.init(path: "/api/v1/statuses/\(id)/reblog", method: .post(.empty))
            }
        }

        /// Unreblogs a status.
        open class Unreblog: RequestBase<Status> {
            /// - Parameter id: The status id.
            public init(id: String) {
                super.init(path: "/api/v1/statuses/\(id)/unreblog", method: .post(.empty))
            }
        }

        /// Favourites a status.
        open class Favourite: RequestBase<Status> {
            /// - Parameter id: The status id.
            public init(id: String) {
                super.init(path: "/api/v1/statuses/\(id)/favourite", method: .post(.empty))
            }
        }

        /// Unfavourites a status.
        open class Unfavourite: RequestBase<Status> {
            /// - Parameter id: The status id.
            public init(id: String) {
                super.init(path: "/api/v1/statuses/\(id)/unfavourite", method: .post(.empty))
            }
        }

        open class Bookmark: RequestBase<Status> {
            /// Bookmarks a status.
            ///
            /// - Parameter id: The status id.
            public init(id: String) {
                super.init(path: "/api/v1/statuses/\(id)/bookmark", method: .post(.empty))
            }
        }

        open class Unbookmark: RequestBase<Status> {
            /// Unbookmarks a status.
            ///
            /// - Parameter id: The status id.
            public init(id: String) {
                super.init(path: "/api/v1/statuses/\(id)/unbookmark", method: .post(.empty))
            }
        }

        /// Pins a status.
        open class Pin: RequestBase<Status> {
            /// - Parameter id: The status id.
            public init(id: String) {
                super.init(path: "/api/v1/statuses/\(id)/pin", method: .post(.empty))
            }
        }

        /// Unpins a status.
        open class Unpin: RequestBase<Status> {
            /// - Parameter id: The status id.
            public init(id: String) {
                super.init(path: "/api/v1/statuses/\(id)/unpin", method: .post(.empty))
            }
        }

        /// Mutes a status.
        open class Mute: RequestBase<Status> {
            /// - Parameter id: The status id.
            public init(id: String) {
                super.init(path: "/api/v1/statuses/\(id)/mute", method: .post(.empty))
            }
        }

        /// Unmutes a status.
        open class Unmute: RequestBase<Status> {
            /// - Parameter id: The status id.
            public init(id: String) {
                super.init(path: "/api/v1/statuses/\(id)/unmute", method: .post(.empty))
            }
        }
    }
}
