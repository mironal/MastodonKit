//
//  Results.swift
//  MastodonKit
//
//  Created by Ornithologist Coder on 4/19/17.
//  Copyright © 2017 MastodonKit. All rights reserved.
//

import Foundation

public struct Results: Codable, Hashable {
    /// An array of matched accounts.
    public let accounts: [Account]
    /// An array of matchhed statuses.
    public let statuses: [Status]
    /// An array of matched hashtags, as strings.
    public let hashtags: [String]

    public init(accounts: [Account], statuses: [Status], hashtags: [String]) {
        self.accounts = accounts
        self.statuses = statuses
        self.hashtags = hashtags
    }
}
