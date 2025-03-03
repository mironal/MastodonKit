//
//  RequestError.swift
//  MastodonKit
//
//  Created by Ornithologist Coder on 4/15/17.
//  Copyright © 2017 MastodonKit. All rights reserved.
//

import Foundation

struct MastodonError: Codable, Hashable {
    /// Reason why Mastodon returned an error.
    let description: String

    public init(description: String) {
        self.description = description
    }

    private enum CodingKeys: String, CodingKey {
        case description = "error"
    }
}
