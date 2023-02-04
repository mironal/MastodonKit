//
//  Accounts.swift
//  MastodonKit
//
//  Created by Ornithologist Coder on 4/9/17.
//  Copyright © 2017 MastodonKit. All rights reserved.
//

import Foundation

extension MastodonRequests {
    /// `Accounts` requests.
    public enum Accounts {
        /// Fetches an account.
        open class AccountByID: RequestBase<Account> {
            /// - Parameter id: The account id.
            public init(_ id: String) {
                super.init(path: "/api/v1/accounts/\(id)")
            }
        }

        /// Gets the current user.
        open class CurrentUser: RequestBase<Account> {
            public init() {
                super.init(path: "/api/v1/accounts/verify_credentials")
            }
        }

        /// Updates the current user.
        open class UpdateCurrentUser: RequestBase<Account> {
            /// - Parameters:
            ///   - displayName: The name to display in the user's profile.
            ///   - note: A new biography for the user.
            ///   - avatar: The media attachment to display as the user's avatar.
            ///   - header: The media attachment to display as the user's header image.
            public init(
                displayName: String? = nil,
                note: String? = nil,
                avatar: MediaAttachment? = nil,
                header: MediaAttachment? = nil
            ) {
                let parameters = [
                    Parameter(name: "display_name", value: displayName),
                    Parameter(name: "note", value: note),
                    Parameter(name: "avatar", value: avatar?.base64EncondedString),
                    Parameter(name: "header", value: header?.base64EncondedString)
                ]
                super.init(path: "/api/v1/accounts/update_credentials", method: .patch(.parameters(parameters)))
            }
        }

        /// Gets an account's followers.
        open class Followers: RequestBase<[Account]> {
            /// - Parameters:
            ///   - id: The account id.
            ///   - range: The bounds used when requesting data from Mastodon.
            public init(id: String, range: RequestRange = .default) {
                let parameters = range.parameters(limit: between(1, and: 80, default: 40))
                super.init(path: "/api/v1/accounts/\(id)/followers", method: .get(.parameters(parameters)))
            }
        }

        /// Gets who account is following.
        open class Following: RequestBase<[Account]> {
            /// - Parameters:
            ///   - id: The account id
            ///   - range: The bounds used when requesting data from Mastodon.
            public init(id: String, range: RequestRange = .default) {
                let parameters = range.parameters(limit: between(1, and: 80, default: 40))
                super.init(path: "/api/v1/accounts/\(id)/following", method: .get(.parameters(parameters)))
            }
        }

        /// Gets an account's statuses.
        open class Statuses: RequestBase<[Status]> {
            /// - Parameters:
            ///   - id: The account id.
            ///   - mediaOnly: Only return statuses that have media attachments.
            ///   - pinnedOnly: Only return statuses that have been pinned.
            ///   - excludeReplies: Skip statuses that reply to other statuses.
            ///   - range: The bounds used when requesting data from Mastodon.
            public init(id: String,
                        mediaOnly: Bool? = nil,
                        pinnedOnly: Bool? = nil,
                        excludeReplies: Bool? = nil,
                        range: RequestRange = .default) {
                let rangeParameters = range.parameters(limit: between(1, and: 40, default: 20)) ?? []
                let parameters = rangeParameters + [
                    Parameter(name: "only_media", value: mediaOnly.flatMap(trueOrNil)),
                    Parameter(name: "pinned", value: pinnedOnly.flatMap(trueOrNil)),
                    Parameter(name: "exclude_replies", value: excludeReplies.flatMap(trueOrNil))
                ]

                super.init(path: "/api/v1/accounts/\(id)/statuses", method: .get(.parameters(parameters)))
            }
        }

        /// Follows an account.
        open class Follow: RequestBase<Relationship> {
            /// - Parameter id: The account id.
            /// - Returns: Request for `Account`.
            public init(id: String) {
                super.init(path: "/api/v1/accounts/\(id)/follow", method: .post(.empty))
            }
        }

        /// Unfollow an account.
        open class Unfollow: RequestBase<Relationship> {
            /// - Parameter id: The account id.
            public init(id: String){
                super.init(path: "/api/v1/accounts/\(id)/unfollow", method: .post(.empty))
            }
        }

        /// Follows a remote user:.
        open class RemoteFollow: RequestBase<Account> {
            /// - Parameter uri: The 'username@domain' of the remote user to follow.
            public init(uri: String) {
                let parameter = [Parameter(name: "uri", value: uri)]
                super.init(path: "/api/v1/follows", method: .post(.parameters(parameter)))
            }
        }

        /// Blocks an account.
        open class Block: RequestBase<Relationship> {
            /// - Parameter id: The account id.
            public init(id: String) {
                super.init(path: "/api/v1/accounts/\(id)/block", method: .post(.empty))
            }
        }

        /// Unblocks an account.
        open class Unblock: RequestBase<Relationship> {
            /// - Parameter id: The account id.
            public init(id: String) {
                super.init(path: "/api/v1/accounts/\(id)/unblock", method: .post(.empty))
            }
        }

        /// Mutes an account.
        open class Mute: RequestBase<Relationship> {
            /// - Parameter id: The account id.
            public init(id: String) {
                super.init(path: "/api/v1/accounts/\(id)/mute", method: .post(.empty))
            }
        }

        /// Unmutes an account.
        open class Unmute: RequestBase<Relationship> {
            /// - Parameter id: The account id.
            public init(id: String) {
                super.init(path: "/api/v1/accounts/\(id)/unmute", method: .post(.empty))
            }
        }

        /// Gets an account's relationships.
        open class Relationships: RequestBase<[Relationship]> {
            /// - Parameter ids: The account's ids.
            public init(ids: [String]) {
                let parameters = ids.map(toArrayOfParameters(withName: "id"))
                super.init(path: "/api/v1/accounts/relationships", method: .get(.parameters(parameters)))
            }
        }

        /// Searches for accounts.
        open class Search: RequestBase<[Account]> {
            /// - Parameters:
            ///   - query: What to search for.
            ///   - limit: Maximum number of matching accounts to return (default: 40).
            ///   - following: Limit the search to following (default: false).
            /// - Returns: Request for `[Account]`.
            public init(query: String, limit: Int? = nil, following: Bool? = nil) {
                let toLimitBounds = between(1, and: 80, default: 40)
                let parameters = [
                    Parameter(name: "q", value: query),
                    Parameter(name: "limit", value: limit.map(toLimitBounds).flatMap(toOptionalString)),
                    Parameter(name: "following", value: following.flatMap(trueOrNil))
                ]
                super.init(path: "/api/v1/accounts/search", method: .get(.parameters(parameters)))
            }
        }
    }
}


