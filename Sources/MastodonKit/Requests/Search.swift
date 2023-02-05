//
//  Search.swift
//  MastodonKit
//
//  Created by Ornithologist Coder on 4/9/17.
//  Copyright © 2017 MastodonKit. All rights reserved.
//

import Foundation

extension Requests {
    /// `Search` requests.
    public enum Search {
        /// Searches for content.
        open class Search: RequestBase<Results> {
            /// - Parameters:
            ///   - query: The search query.
            ///   - resolve: Whether to resolve non-local accounts.
            public init(query: String, resolve: Bool? = nil) {
                let parameters = [
                    Parameter(name: "q", value: query),
                    Parameter(name: "resolve", value: resolve.flatMap(trueOrNil))
                ]
                super.init(path: "/api/v1/search", method: .get(.parameters(parameters)))
            }
        }
    }
}
