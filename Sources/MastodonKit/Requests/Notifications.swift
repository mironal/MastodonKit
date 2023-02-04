//
//  Notifications.swift
//  MastodonKit
//
//  Created by Ornithologist Coder on 5/17/17.
//  Copyright © 2017 MastodonKit. All rights reserved.
//

import Foundation

extension MastodonRequests {
    /// `Notifications` requests.
    public enum Notifications {
        /// Fetches a user's notifications.
        open class All: RequestBase<[Notification]> {
            /// - Parameter range: The bounds used when requesting data from Mastodon.
            public init(range: RequestRange = .default) {
                let parameters = range.parameters(limit: between(1, and: 15, default: 30))
                super.init(path: "/api/v1/notifications", method: .get(.parameters(parameters)))
            }
        }

        /// Gets a single notification.
        open class Get: RequestBase<Notification> {
            /// - Parameter id: The notification id.
            public init(id: String) {
                super.init(path: "/api/v1/notifications/\(id)")
            }
        }

        /// Deletes all notifications for the authenticated user.
        open class DismissAll: RequestBase<Empty> {
            /// - Returns: Request for `Empty`.
            public init() {
                super.init(path: "/api/v1/notifications/clear", method: .post(.empty))
            }
        }

        /// Deletes a single notification for the authenticated user.
        open class Dismiss: RequestBase<Empty> {
            /// - Parameter id: The notification id.
            public init(id: String) {
                let parameter = [Parameter(name: "id", value: String(id))]
                super.init(path: "/api/v1/notifications/dismiss", method: .post(.parameters(parameter)))
            }
        }
    }
}
