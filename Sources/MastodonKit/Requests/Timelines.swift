//
//  Timelines.swift
//  MastodonKit
//
//  Created by Ornithologist Coder on 4/9/17.
//  Copyright © 2017 MastodonKit. All rights reserved.
//

import Foundation

extension Requests {
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
            ///   - remote: Show only remote statuses?
            ///   - only_media: Show only statuses with media attached?
            ///   - range: The bounds used when requesting data from Mastodon.
            public init(local: Bool? = nil, remote: Bool? = nil, onlyMedia: Bool? = nil, range: RequestRange = .default) {
                let rangeParameters = range.parameters(limit: between(1, and: 40, default: 20)) ?? []
                let localParameter = [
                    Parameter(name: "local", value: local.flatMap(trueOrNil)),
                    Parameter(name: "remote", value: remote.flatMap(trueOrNil)),
                    Parameter(name: "only_media", value: onlyMedia.flatMap(trueOrNil))
                ]
                super.init(path: "/api/v1/timelines/public", method: .get(.parameters(localParameter + rangeParameters)))
            }
        }

        /// Retrieves a tag timeline.
        open class Tag: RequestBase<[Status]> {
            /// - Parameters:
            ///   - hashtag: The hashtag.
            ///   - local: Only return statuses originating from this instance.
            ///   - only_media: Show only statuses with media attached?
            ///   - range: The bounds used when requesting data from Mastodon.
            public init(_ hashtag: String, local: Bool? = nil, onlyMedia: Bool? = nil, range: RequestRange = .default) {
                let rangeParameters = range.parameters(limit: between(1, and: 40, default: 20)) ?? []
                let localParameter = [
                    Parameter(name: "local", value: local.flatMap(trueOrNil)),
                    Parameter(name: "only_media", value: onlyMedia.flatMap(trueOrNil))
                ]
                super.init(path: "/api/v1/timelines/tag/\(hashtag)", method: .get(.parameters(localParameter + rangeParameters)))
            }
        }

        /// View statuses in the given list timeline.
        open class List: RequestBase<[Status]> {
            /// - Parameters:
            ///   - id: Local ID of the List.
            ///   - range: The bounds used when requesting data from Mastodon.
            public init(_ id: String, range: RequestRange = .default) {
                let parameters = range.parameters(limit: between(1, and: 40, default: 20)) ?? []
                super.init(path: "/api/v1/timelines/list/\(id)", method: .get(.parameters(parameters)))
            }
        }
    }
}
