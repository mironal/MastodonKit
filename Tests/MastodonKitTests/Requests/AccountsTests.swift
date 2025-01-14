//
//  AccountsTests.swift
//  MastodonKit
//
//  Created by Ornithologist Coder on 5/17/17.
//  Copyright © 2017 MastodonKit. All rights reserved.
//

import XCTest
@testable import MastodonKit

class AccountsTests: XCTestCase {
    func testAccount() {
        let request = Requests.Accounts.AccountByID("42")

        // Endpoint
        XCTAssertEqual(request.path, "/api/v1/accounts/42")

        // Method
        XCTAssertEqual(request.method.name, "GET")
        XCTAssertNil(request.method.queryItems)
        XCTAssertNil(request.method.httpBody)
    }

    func testCurrentUser() {
        let request = Requests.Accounts.CurrentUser()

        // Endpoint
        XCTAssertEqual(request.path, "/api/v1/accounts/verify_credentials")

        // Method
        XCTAssertEqual(request.method.name, "GET")
        XCTAssertNil(request.method.queryItems)
        XCTAssertNil(request.method.httpBody)
    }

    func testUpdateCurrentUserWithAllFields() {
        let avatar = MediaAttachment.jpeg(Data(count: 8))
        let header = MediaAttachment.png(Data(count: 8))

        let request = Requests.Accounts.UpdateCurrentUser(displayName: "Ornithologist Coder", note: "Creator of MastodonKit", avatar: avatar, header: header)

        // Endpoint
        XCTAssertEqual(request.path, "/api/v1/accounts/update_credentials")

        // Method
        XCTAssertEqual(request.method.name, "PATCH")
        XCTAssertNil(request.method.queryItems)
        XCTAssertNotNil(request.method.httpBody)

        let payload = String(data: request.method.httpBody!, encoding: .utf8)!
        XCTAssertEqual(payload.components(separatedBy: "&").count, 4)
        XCTAssertTrue(payload.contains("display_name=Ornithologist%20Coder"))
        XCTAssertTrue(payload.contains("note=Creator%20of%20MastodonKit"))
        XCTAssertTrue(payload.contains("avatar=data%3Aimage/jpg%3Bbase64%2CAAAAAAAAAAA%3D"))
        XCTAssertTrue(payload.contains("header=data%3Aimage/png%3Bbase64%2CAAAAAAAAAAA%3D"))
    }

    func testUpdateCurrentUserWithSomeFields() {
        let request = Requests.Accounts.UpdateCurrentUser(displayName: "Ornithologist Coder", note: "Creator of MastodonKit")

        // Endpoint
        XCTAssertEqual(request.path, "/api/v1/accounts/update_credentials")

        // Method
        XCTAssertEqual(request.method.name, "PATCH")
        XCTAssertNil(request.method.queryItems)
        XCTAssertNotNil(request.method.httpBody)

        let payload = String(data: request.method.httpBody!, encoding: .utf8)!
        XCTAssertEqual(payload.components(separatedBy: "&").count, 2)
        XCTAssertTrue(payload.contains("display_name=Ornithologist%20Coder"))
        XCTAssertTrue(payload.contains("note=Creator%20of%20MastodonKit"))
    }

    func testFollowers() {
        let request = Requests.Accounts.Followers(id: "42")

        // Endpoint
        XCTAssertEqual(request.path, "/api/v1/accounts/42/followers")

        // Method
        XCTAssertEqual(request.method.name, "GET")
        XCTAssertNil(request.method.queryItems)
        XCTAssertNil(request.method.httpBody)
    }

    func testFollowersWithRange() {
        let request = Requests.Accounts.Followers(id: "42", range: .since(id: "420", limit: 37))
        let expectedMaxID = URLQueryItem(name: "since_id", value: "420")
        let expectedLimit = URLQueryItem(name: "limit", value: "37")

        // Endpoint
        XCTAssertEqual(request.path, "/api/v1/accounts/42/followers")

        // Method
        XCTAssertEqual(request.method.name, "GET")
        XCTAssertNil(request.method.httpBody)
        XCTAssertEqual(request.method.queryItems?.count, 2)
        XCTAssertTrue(request.method.queryItems!.contains(expectedMaxID))
        XCTAssertTrue(request.method.queryItems!.contains(expectedLimit))
    }

    func testFollowing() {
        let request = Requests.Accounts.Following(id: "42")

        // Endpoint
        XCTAssertEqual(request.path, "/api/v1/accounts/42/following")

        // Method
        XCTAssertEqual(request.method.name, "GET")
        XCTAssertNil(request.method.queryItems)
        XCTAssertNil(request.method.httpBody)
    }

    func testFollowingWithRange() {
        let request = Requests.Accounts.Following(id: "42", range: .limit(17))
        let expectedLimit = URLQueryItem(name: "limit", value: "17")

        // Endpoint
        XCTAssertEqual(request.path, "/api/v1/accounts/42/following")

        // Method
        XCTAssertEqual(request.method.name, "GET")
        XCTAssertNil(request.method.httpBody)
        XCTAssertEqual(request.method.queryItems?.count, 1)
        XCTAssertTrue(request.method.queryItems!.contains(expectedLimit))
    }

    func testStatuses() {
        let request = Requests.Accounts.Statuses(id: "42")

        // Endpoint
        XCTAssertEqual(request.path, "/api/v1/accounts/42/statuses")

        // Method
        XCTAssertEqual(request.method.name, "GET")
        XCTAssertEqual(request.method.queryItems?.count, 0)
        XCTAssertNil(request.method.httpBody)
    }

    func testStatusesWithRange() {
        let request = Requests.Accounts.Statuses(id: "42", range: .since(id: "10", limit: 20))
        let expectedSinceID = URLQueryItem(name: "since_id", value: "10")
        let expectedLimit = URLQueryItem(name: "limit", value: "20")

        // Endpoint
        XCTAssertEqual(request.path, "/api/v1/accounts/42/statuses")

        // Method
        XCTAssertEqual(request.method.name, "GET")
        XCTAssertNil(request.method.httpBody)
        XCTAssertEqual(request.method.queryItems?.count, 2)
        XCTAssertTrue(request.method.queryItems!.contains(expectedSinceID))
        XCTAssertTrue(request.method.queryItems!.contains(expectedLimit))
    }

    func testStatusesWithMediaOnly() {
        let request = Requests.Accounts.Statuses(id: "42", mediaOnly: true)
        let expectedFlag = URLQueryItem(name: "only_media", value: "true")

        // Endpoint
        XCTAssertEqual(request.path, "/api/v1/accounts/42/statuses")

        // Method
        XCTAssertEqual(request.method.name, "GET")
        XCTAssertTrue(request.method.queryItems!.contains(expectedFlag))
        XCTAssertNil(request.method.httpBody)
    }

    func testStatusesWithPinnedStatusOnly() {
        let request = Requests.Accounts.Statuses(id: "42", pinnedOnly: true)
        let expectedFlag = URLQueryItem(name: "pinned", value: "true")

        // Endpoint
        XCTAssertEqual(request.path, "/api/v1/accounts/42/statuses")

        // Method
        XCTAssertEqual(request.method.name, "GET")
        XCTAssertTrue(request.method.queryItems!.contains(expectedFlag))
        XCTAssertNil(request.method.httpBody)
    }

    func testStatusesWithoutReplies() {
        let request = Requests.Accounts.Statuses(id: "42", excludeReplies: true)
        let expectedFlag = URLQueryItem(name: "exclude_replies", value: "true")

        // Endpoint
        XCTAssertEqual(request.path, "/api/v1/accounts/42/statuses")

        // Method
        XCTAssertEqual(request.method.name, "GET")
        XCTAssertTrue(request.method.queryItems!.contains(expectedFlag))
        XCTAssertNil(request.method.httpBody)
    }

    func testFollow() {
        let request = Requests.Accounts.Follow(id: "42")

        // Endpoint
        XCTAssertEqual(request.path, "/api/v1/accounts/42/follow")

        // Method
        XCTAssertEqual(request.method.name, "POST")
        XCTAssertNil(request.method.queryItems)
        XCTAssertNil(request.method.httpBody)
    }

    func testUnfollow() {
        let request = Requests.Accounts.Unfollow(id: "42")

        // Endpoint
        XCTAssertEqual(request.path, "/api/v1/accounts/42/unfollow")

        // Method
        XCTAssertEqual(request.method.name, "POST")
        XCTAssertNil(request.method.queryItems)
        XCTAssertNil(request.method.httpBody)
    }

    func testRemoteFollow() {
        let request = Requests.Accounts.RemoteFollow(uri: "username@domain")

        // Endpoint
        XCTAssertEqual(request.path, "/api/v1/follows")

        // Method
        XCTAssertEqual(request.method.name, "POST")
        XCTAssertNil(request.method.queryItems)
        XCTAssertNotNil(request.method.httpBody)

        let payload = String(data: request.method.httpBody!, encoding: .utf8)!
        XCTAssertEqual(payload.components(separatedBy: "&").count, 1)
        XCTAssertTrue(payload.contains("uri=username%40domain"))
    }

    func testBlock() {
        let request = Requests.Accounts.Block(id: "42")

        // Endpoint
        XCTAssertEqual(request.path, "/api/v1/accounts/42/block")

        // Method
        XCTAssertEqual(request.method.name, "POST")
        XCTAssertNil(request.method.queryItems)
        XCTAssertNil(request.method.httpBody)
    }

    func testUnblock() {
        let request = Requests.Accounts.Unblock(id: "42")

        // Endpoint
        XCTAssertEqual(request.path, "/api/v1/accounts/42/unblock")

        // Method
        XCTAssertEqual(request.method.name, "POST")
        XCTAssertNil(request.method.queryItems)
        XCTAssertNil(request.method.httpBody)
    }

    func testMute() {
        let request = Requests.Accounts.Mute(id: "42")

        // Endpoint
        XCTAssertEqual(request.path, "/api/v1/accounts/42/mute")

        // Method
        XCTAssertEqual(request.method.name, "POST")
        XCTAssertNil(request.method.queryItems)
        XCTAssertNil(request.method.httpBody)
    }

    func testUnmute() {
        let request = Requests.Accounts.Unmute(id: "42")

        // Endpoint
        XCTAssertEqual(request.path, "/api/v1/accounts/42/unmute")

        // Method
        XCTAssertEqual(request.method.name, "POST")
        XCTAssertNil(request.method.queryItems)
        XCTAssertNil(request.method.httpBody)
    }

    func testRelationships() {
        let request = Requests.Accounts.Relationships(ids: ["42", "52"])
        let expectedID42 = URLQueryItem(name: "id[]", value: "42")
        let expectedID52 = URLQueryItem(name: "id[]", value: "52")

        // Endpoint
        XCTAssertEqual(request.path, "/api/v1/accounts/relationships")

        // Method
        XCTAssertEqual(request.method.name, "GET")
        XCTAssertNil(request.method.httpBody)
        XCTAssertNotNil(request.method.queryItems)
        XCTAssertEqual(request.method.queryItems?.count, 2)
        XCTAssertTrue(request.method.queryItems!.contains(expectedID42))
        XCTAssertTrue(request.method.queryItems!.contains(expectedID52))
    }

    func testSearchWithoutLimit() {
        let request = Requests.Accounts.Search(query: "Ash")
        let expectedQuery = URLQueryItem(name: "q", value: "Ash")

        // Endpoint
        XCTAssertEqual(request.path, "/api/v1/accounts/search")

        // Method
        XCTAssertEqual(request.method.name, "GET")
        XCTAssertNil(request.method.httpBody)
        XCTAssertNotNil(request.method.queryItems)
        XCTAssertEqual(request.method.queryItems?.count, 1)
        XCTAssertTrue(request.method.queryItems!.contains(expectedQuery))
    }

    func testSearchWithValidLimit() {
        let request = Requests.Accounts.Search(query: "Ash", limit: 42)
        let expectedQuery = URLQueryItem(name: "q", value: "Ash")
        let expectedLimit = URLQueryItem(name: "limit", value: "42")

        // Endpoint
        XCTAssertEqual(request.path, "/api/v1/accounts/search")

        // Method
        XCTAssertEqual(request.method.name, "GET")
        XCTAssertNil(request.method.httpBody)
        XCTAssertNotNil(request.method.queryItems)
        XCTAssertEqual(request.method.queryItems?.count, 2)
        XCTAssertTrue(request.method.queryItems!.contains(expectedQuery))
        XCTAssertTrue(request.method.queryItems!.contains(expectedLimit))
    }

    func testSearchWithLimitBelowMinimumValue() {
        let request = Requests.Accounts.Search(query: "Ash", limit: 0)
        let expectedQuery = URLQueryItem(name: "q", value: "Ash")
        let expectedLimit = URLQueryItem(name: "limit", value: "40")

        // Endpoint
        XCTAssertEqual(request.path, "/api/v1/accounts/search")

        // Method
        XCTAssertEqual(request.method.name, "GET")
        XCTAssertNil(request.method.httpBody)
        XCTAssertNotNil(request.method.queryItems)
        XCTAssertEqual(request.method.queryItems?.count, 2)
        XCTAssertTrue(request.method.queryItems!.contains(expectedQuery))
        XCTAssertTrue(request.method.queryItems!.contains(expectedLimit))
    }

    func testSearchWithLimitAboveMaximumValue() {
        let request = Requests.Accounts.Search(query: "Ash", limit: 81)
        let expectedQuery = URLQueryItem(name: "q", value: "Ash")
        let expectedLimit = URLQueryItem(name: "limit", value: "40")

        // Endpoint
        XCTAssertEqual(request.path, "/api/v1/accounts/search")

        // Method
        XCTAssertEqual(request.method.name, "GET")
        XCTAssertNil(request.method.httpBody)
        XCTAssertNotNil(request.method.queryItems)
        XCTAssertEqual(request.method.queryItems?.count, 2)
        XCTAssertTrue(request.method.queryItems!.contains(expectedQuery))
        XCTAssertTrue(request.method.queryItems!.contains(expectedLimit))
    }

    func testSearchWithFollowingValue() {
        let request = Requests.Accounts.Search(query: "Ash", following: true)
        let expectedQuery = URLQueryItem(name: "q", value: "Ash")
        let expectedFollowing = URLQueryItem(name: "following", value: "true")

        // Endpoint
        XCTAssertEqual(request.path, "/api/v1/accounts/search")

        // Method
        XCTAssertEqual(request.method.name, "GET")
        XCTAssertNil(request.method.httpBody)
        XCTAssertNotNil(request.method.queryItems)
        XCTAssertEqual(request.method.queryItems?.count, 2)
        XCTAssertTrue(request.method.queryItems!.contains(expectedQuery))
        XCTAssertTrue(request.method.queryItems!.contains(expectedFollowing))
    }
}
