//
//  Context.swift
//  MastodonKit
//
//  Created by Ornithologist Coder on 4/9/17.
//  Copyright © 2017 MastodonKit. All rights reserved.
//

import Foundation

public struct Context: Codable, Hashable {
    /// The ancestors of the status in the conversation, as a list of statuses.
    public let ancestors: [Status]
    /// The descendants of the status in the conversation, as a list of statuses.
    public let descendants: [Status]

    public init(ancestors: [Status], descendants: [Status]) {
        self.ancestors = ancestors
        self.descendants = descendants
    }
}
