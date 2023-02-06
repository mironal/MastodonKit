//
//  Instance.swift
//  MastodonKit
//
//  Created by Ornithologist Coder on 4/9/17.
//  Copyright © 2017 MastodonKit. All rights reserved.
//

import Foundation

public struct Instance: Codable, Hashable {
    public struct Stats: Codable, Hashable {
        /// Total users on this instance.
        public let userCount: Int
        /// Total statuses on this instance.
        public let statusCount: Int
        /// Total domains discovered by this instance.
        public let domainCount: Int

        public init(userCount: Int, statusCount: Int, domainCount: Int) {
            self.userCount = userCount
            self.statusCount = statusCount
            self.domainCount = domainCount
        }

        private enum CodingKeys: String, CodingKey {
            case userCount = "user_count"
            case statusCount = "status_count"
            case domainCount = "domain_count"
        }
    }
    /// URI of the current instance.
    public let uri: String
    /// The instance's title.
    public let title: String
    /// A short, plain-text description defined by the admin.
    public let shortDescription: String
    /// A description for the instance.
    public let description: String
    /// An email address which can be used to contact the instance administrator.
    public let email: String
    /// The Mastodon version used by instance (as of version 1.3).
    public let version: String?
    /// URLs for Streaming API
    public let urls: [String: String]?
    /// Statistics about how much information the instance contains.
    public let stats: Stats
    /// A user that can be contacted, as an alternative to email.
    public let contactAccount: Account

    public init(uri: String, title: String, shortDescription: String, description: String, email: String, version: String? = nil, urls: [String : String]? = nil, stats: Stats, contactAccount: Account) {
        self.uri = uri
        self.title = title
        self.shortDescription = shortDescription
        self.description = description
        self.email = email
        self.version = version
        self.urls = urls
        self.stats = stats
        self.contactAccount = contactAccount
    }

    private enum CodingKeys: String, CodingKey {
        case uri
        case title
        case shortDescription = "short_description"
        case description
        case email
        case version
        case urls
        case stats
        case contactAccount = "contact_account"
    }
}
