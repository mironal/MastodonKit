//
//  Account.swift
//  MastodonKit
//
//  Created by Ornithologist Coder on 4/9/17.
//  Copyright © 2017 MastodonKit. All rights reserved.
//

import Foundation

public struct Account: Codable, Hashable {
    /// The ID of the account.
    public let id: String
    /// The username of the account.
    public let username: String
    /// Equals username for local users, includes @domain for remote ones.
    public let acct: String
    /// The account's display name.
    public let displayName: String
    /// Biography of user.
    public let note: String
    /// URL of the user's profile page (can be remote).
    public let url: String
    /// URL to the avatar image.
    public let avatar: String
    /// URL to the avatar static image
    public let avatarStatic: String
    /// URL to the header image.
    public let header: String
    /// URL to the header static image
    public let headerStatic: String
    /// Boolean for when the account cannot be followed without waiting for approval first.
    public let locked: Bool
    /// The time the account was created.
    public let createdAt: Date
    /// The number of followers for the account.
    public let followersCount: Int
    /// The number of accounts the given account is following.
    public let followingCount: Int
    /// The number of statuses the account has made.
    public let statusesCount: Int

    /// An array of `Emoji`.
    public var emojis: [Emoji] {
        return _emojis ?? []
    }
    /// Additional metadata attached to a profile as name-value pairs.
    public var fields: [Field] {
        return _fields ?? []
    }
    /// Indicates that the account may perform automated actions, may not be monitored, or identifies as a robot.
    public var bot: Bool {
        return _bot ?? false
    }
    /// Indicates that the account represents a Group actor
    public var group: Bool {
        return _group ?? false
    }

    /// Real storage of emojis.
    ///
    /// According to the [documentation](https://docs.joinmastodon.org/api/entities/#account),
    /// property emoji is added in 2.4.0, and it is non-optional. But for compibility with older version instance, we
    /// use `[Emoji]?` as storage and use `[Emoji]` as public API.
    private let _emojis: [Emoji]?
    private let _fields: [Field]?
    private let _bot: Bool?
    private let _group: Bool?

    public init(id: String, username: String, acct: String, displayName: String, note: String, url: String, avatar: String, avatarStatic: String, header: String, headerStatic: String, locked: Bool, createdAt: Date, followersCount: Int, followingCount: Int, statusesCount: Int, emojis: [Emoji]?, fields: [Field], bot: Bool, group: Bool) {
        self.id = id
        self.username = username
        self.acct = acct
        self.displayName = displayName
        self.note = note
        self.url = url
        self.avatar = avatar
        self.avatarStatic = avatarStatic
        self.header = header
        self.headerStatic = headerStatic
        self.locked = locked
        self.createdAt = createdAt
        self.followersCount = followersCount
        self.followingCount = followingCount
        self.statusesCount = statusesCount
        self._emojis = emojis
        self._fields = fields
        self._bot = bot
        self._group = group
    }


    private enum CodingKeys: String, CodingKey {
        case id
        case username
        case acct
        case displayName = "display_name"
        case note
        case url
        case avatar
        case avatarStatic = "avatar_static"
        case header
        case headerStatic = "header_static"
        case locked
        case createdAt = "created_at"
        case followersCount = "followers_count"
        case followingCount = "following_count"
        case statusesCount = "statuses_count"
        case _emojis = "emojis"
        case _fields = "fields"
        case _bot = "bot"
        case _group = "group"
    }
}
