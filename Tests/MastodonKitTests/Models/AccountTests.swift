//
//  AccountTests.swift
//  MastodonKit
//
//  Created by Ornithologist Coder on 4/15/17.
//  Copyright © 2017 MastodonKit. All rights reserved.
//

import XCTest
@testable import MastodonKit

class AccountTests: XCTestCase {
    func testAccountFromJSON() {
        let fixture = try! Fixture.load(fileName: "Fixtures/Account.json")
        let account = try? Account.decode(data: fixture)

        XCTAssertEqual(account?.id, "1")
        XCTAssertEqual(account?.username, "ornithocoder")
        XCTAssertEqual(account?.acct, "ornithocoder")
        XCTAssertEqual(account?.displayName, "Ornithologist Coder")
        XCTAssertEqual(account?.note, "Developer of MastodonKit")
        XCTAssertEqual(account?.url, "https://mastodon.technology/@ornithocoder")
        XCTAssertEqual(account?.avatar, "http://lorempixel.com/200/200/cats/3/")
        XCTAssertEqual(account?.avatarStatic, "http://lorempixel.com/300/300/cats/3/")
        XCTAssertEqual(account?.header, "http://lorempixel.com/700/300/cats/1/")
        XCTAssertEqual(account?.headerStatic, "http://lorempixel.com/800/400/cats/1/")
        XCTAssertEqual(account?.locked, false)
        XCTAssertEqual(account?.createdAt.timeIntervalSince1970, 1482239655.132)
        XCTAssertEqual(account?.followersCount, 42)
        XCTAssertEqual(account?.followingCount, 52)
        XCTAssertEqual(account?.statusesCount, 420)
        XCTAssertEqual(account?.emojis.first?.shortcode, "mastodon")
        XCTAssertEqual(account?.emojis.first?.url, URL(string: "https://static.mastodon.technology/custom_emojis/images/000/000/435/original/61371621aea40c9e.png"))
        XCTAssertEqual(account?.emojis.first?.staticURL, URL(string: "https://static.mastodon.technology/custom_emojis/images/000/000/435/static/61371621aea40c9e.png"))
        XCTAssertEqual(account?.fields[0], .init(name: "Pronouns", value: "they/them", verifiedAt: nil))
        XCTAssertEqual(account?.fields[1], .init(name: "Alt", value: "<span class=\"h-card\"><a href=\"https://cybre.space/@noiob\" class=\"u-url mention\" rel=\"nofollow noopener noreferrer\" target=\"_blank\">@<span>noiob</span}</span>", verifiedAt: nil))
        XCTAssertEqual(account?.fields[2], .init(name: "Website", value: "<a href=\"http://shork.xyz\" rel=\"nofollow noopener noreferrer\" target=\"_blank\"><span class=\"invisible\">http://</span><span class=\"\">shork.xyz</span><span class=\"invisible\"></span}", verifiedAt: Date(timeIntervalSince1970: 1573381870.744)))
    }

    func testAccountWithInvalidData() {
        let parsed = try? Account.decode(data: Data())

        XCTAssertNil(parsed)
    }

    func testAccountsFromJSON() {
        let fixture = try! Fixture.load(fileName: "Fixtures/Accounts.json")
        let parsed = try? [Account].decode(data: fixture)

        XCTAssertEqual(parsed?.count, 2)
    }

    func testAccountsWithInvalidData() {
        let parsed = try? [Account].decode(data: Data())

        XCTAssertNil(parsed)
    }
}
