//
//  Blocks.swift
//  MastodonKit
//
//  Created by Ornithologist Coder on 4/9/17.
//  Copyright © 2017 MastodonKit. All rights reserved.
//

import Foundation

extension Requests {
    /// `Blocks` requests.
    public enum Blocks {
        /// Fetches a user's blocks.
        open class All: RequestBase<[Account]> {
            /// - Parameter range: The bounds used when requesting data from Mastodon.
            public init(range: RequestRange = .default) {
                let parameters = range.parameters(limit: between(1, and: 80, default: 40))
                super.init(path: "/api/v1/blocks", method: .get(.parameters(parameters)))
            }
        }
    }
}
