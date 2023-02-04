//
//  Instances.swift
//  MastodonKit
//
//  Created by Ornithologist Coder on 5/17/17.
//  Copyright © 2017 MastodonKit. All rights reserved.
//

import Foundation

extension MastodonRequests {
    /// `Instances` requests.
    public enum Instances {
        /// Gets instance information.
        open class Current: RequestBase<Instance> {
            /// - Returns: Request for `Instance`.
            public init() {
                super.init(path: "/api/v1/instance")
            }
        }

        /// Fetches current instance's custom emojis.
        open class CustomEmojis: RequestBase<[Emoji]> {
            /// - Returns: Request for `[Emoji]`.
            public init() {
                super.init(path: "/api/v1/custom_emojis")
            }
        }
    }
}
