//
//  Favourites.swift
//  MastodonKit
//
//  Created by Ornithologist Coder on 4/9/17.
//  Copyright © 2017 MastodonKit. All rights reserved.
//

import Foundation

extension MastodonRequests {
    /// `Favourites` requests.
    public enum Favourites {
        /// Fetches a user's favourites.
        open class All: RequestBase<[Status]> {
            /// - Parameter range: The bounds used when requesting data from Mastodon.
            public init(range: RequestRange = .default) {
                let parameters = range.parameters(limit: between(1, and: 40, default: 20))
                super.init(path: "/api/v1/favourites", method: .get(.parameters(parameters)))
            }
        }
    }
}
