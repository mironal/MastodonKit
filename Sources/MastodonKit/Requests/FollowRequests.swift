//
//  FollowRequests.swift
//  MastodonKit
//
//  Created by Ornithologist Coder on 5/17/17.
//  Copyright © 2017 MastodonKit. All rights reserved.
//

import Foundation

extension MastodonRequests {
    /// `FollowRequests` requests.
    public enum FollowRequests {
        /// Fetches a list of follow requests.
        open class All: RequestBase<[Account]> {
            /// - Parameter range: The bounds used when requesting data from Mastodon.
            public init(range: RequestRange = .default) {
                let parameters = range.parameters(limit: between(1, and: 80, default: 40))
                super.init(path: "/api/v1/follow_requests", method: .get(.parameters(parameters)))
            }
        }

        /// Authorizes a follow request.
        open class Authorize: RequestBase<Empty> {
            /// - Parameter id: The accound id.
            public init(id: String) {
                super.init(path: "/api/v1/follow_requests/\(id)/authorize", method: .post(.empty))
            }
        }

        /// Rejects a follow request.
        open class Reject: RequestBase<Empty> {
            /// - Parameter id: The accound id.
            public init(id: String) {
                super.init(path: "/api/v1/follow_requests/\(id)/reject", method: .post(.empty))
            }
        }
    }
}
