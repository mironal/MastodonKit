//
//  DomainBlocks.swift
//  MastodonKit
//
//  Created by Ornithologist Coder on 6/5/17.
//  Copyright © 2017 MastodonKit. All rights reserved.
//

import Foundation

extension Requests {
    /// `DomainBlocks` requests.
    public enum DomainBlocks {
        /// Fetches a user's blocked domains.
        open class All: RequestBase<[String]> {
            /// - Parameter range: The bounds used when requesting data from Mastodon.
            public init(range: RequestRange = .default) {
                let parameters = range.parameters(limit: between(1, and: 80, default: 40))
                super.init(path: "/api/v1/domain_blocks", method: .get(.parameters(parameters)))
            }
        }

        /// Blocks a domain.
        open class Block: RequestBase<Empty> {
            /// - Parameter domain: The domain to block.
            public init(domain: String) {
                let parameter = [Parameter(name: "domain", value: domain)]
                super.init(path: "/api/v1/domain_blocks", method: .post(.parameters(parameter)))
            }
        }

        /// Unblocks a domain.
        open class Unblock: RequestBase<Empty> {
            /// - Parameter domain: The domain to unblock.
            public init(domain: String) {
                let parameter = [Parameter(name: "domain", value: domain)]
                super.init(path: "/api/v1/domain_blocks", method: .delete(.parameters(parameter)))
            }
        }
    }
}
