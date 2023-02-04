//
//  Timelines.swift
//  MastodonKit
//
//  Created by Ornithologist Coder on 4/9/17.
//  Copyright © 2017 MastodonKit. All rights reserved.
//

import Foundation

extension MastodonRequests {
    /// `Timelines` requests.
    public enum Timelines {
        /// Retrieves the home timeline.
        open class Home: RequestBase<[Status]> {
            /// - Parameter range: The bounds used when requesting data from Mastodon.
            public init(range: RequestRange = .default) {
                let parameters = range.parameters(limit: between(1, and: 40, default: 20))
                super.init(path: "/api/v1/timelines/home", method: .get(.parameters(parameters)))
            }
        }

        /// Retrieves the public timeline.
        open class Public: RequestBase<[Status]> {
            /// - Parameters:
            ///   - local: Only return statuses originating from this instance.
            ///   - range: The bounds used when requesting data from Mastodon.
            public init(local: Bool? = nil, range: RequestRange = .default) {
                let rangeParameters = range.parameters(limit: between(1, and: 40, default: 20)) ?? []
                let localParameter = [Parameter(name: "local", value: local.flatMap(trueOrNil))]
                super.init(path: "/api/v1/timelines/public", method: .get(.parameters(localParameter + rangeParameters)))
            }
        }

        /// Retrieves a tag timeline.
        open class Tag: RequestBase<[Status]> {
            /// - Parameters:
            ///   - hashtag: The hashtag.
            ///   - local: Only return statuses originating from this instance.
            ///   - range: The bounds used when requesting data from Mastodon.
            public init(_ hashtag: String, local: Bool? = nil, range: RequestRange = .default) {
                let rangeParameters = range.parameters(limit: between(1, and: 40, default: 20)) ?? []
                let localParameter = [Parameter(name: "local", value: local.flatMap(trueOrNil))]
                super.init(path: "/api/v1/timelines/tag/\(hashtag)", method: .get(.parameters(localParameter + rangeParameters)))
            }
        }
    }
}
