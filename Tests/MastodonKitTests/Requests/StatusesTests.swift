//
//  StatusesTests.swift
//  MastodonKit
//
//  Created by Ornithologist Coder on 5/17/17.
//  Copyright © 2017 MastodonKit. All rights reserved.
//

import XCTest
@testable import MastodonKit

class StatusesTests: XCTestCase {
    func testStatus() {
        let request = Requests.Statuses.StatusBy(id: "42")

        // Endpoint
        XCTAssertEqual(request.path, "/api/v1/statuses/42")

        // Method
        XCTAssertEqual(request.method.name, "GET")
        XCTAssertNil(request.method.httpBody)
        XCTAssertNil(request.method.queryItems)
    }

    func testContext() {
        let request = Requests.Statuses.ContextBy(id: "42")

        // Endpoint
        XCTAssertEqual(request.path, "/api/v1/statuses/42/context")

        // Method
        XCTAssertEqual(request.method.name, "GET")
        XCTAssertNil(request.method.httpBody)
        XCTAssertNil(request.method.queryItems)
    }

    func testCard() {
        let request = Requests.Statuses.CardBy(id: "42")

        // Endpoint
        XCTAssertEqual(request.path, "/api/v1/statuses/42/card")

        // Method
        XCTAssertEqual(request.method.name, "GET")
        XCTAssertNil(request.method.httpBody)
        XCTAssertNil(request.method.queryItems)
    }

    func testRebloggedBy() {
        let request = Requests.Statuses.RebloggedBy(id: "42")

        // Endpoint
        XCTAssertEqual(request.path, "/api/v1/statuses/42/reblogged_by")

        // Method
        XCTAssertEqual(request.method.name, "GET")
        XCTAssertNil(request.method.httpBody)
        XCTAssertNil(request.method.queryItems)
    }

    func testRebloggedByWithRange() {
        let request = Requests.Statuses.RebloggedBy(id: "42", range: .since(id: "12", limit: 50))
        let expectedSinceID = URLQueryItem(name: "since_id", value: "12")
        let expectedLimit = URLQueryItem(name: "limit", value: "50")

        // Endpoint
        XCTAssertEqual(request.path, "/api/v1/statuses/42/reblogged_by")

        // Method
        XCTAssertEqual(request.method.name, "GET")
        XCTAssertNil(request.method.httpBody)
        XCTAssertEqual(request.method.queryItems?.count, 2)
        XCTAssertTrue(request.method.queryItems!.contains(expectedSinceID))
        XCTAssertTrue(request.method.queryItems!.contains(expectedLimit))
    }

    func testFavouritedBy() {
        let request = Requests.Statuses.FavouritedBy(id: "42")

        // Endpoint
        XCTAssertEqual(request.path, "/api/v1/statuses/42/favourited_by")

        // Method
        XCTAssertEqual(request.method.name, "GET")
        XCTAssertNil(request.method.httpBody)
        XCTAssertNil(request.method.queryItems)
    }

    func testFavouritedByWithRange() {
        let request = Requests.Statuses.FavouritedBy(id: "42", range: .since(id: "12", limit: 50))
        let expectedSinceID = URLQueryItem(name: "since_id", value: "12")
        let expectedLimit = URLQueryItem(name: "limit", value: "50")

        // Endpoint
        XCTAssertEqual(request.path, "/api/v1/statuses/42/favourited_by")

        // Method
        XCTAssertEqual(request.method.name, "GET")
        XCTAssertNil(request.method.httpBody)
        XCTAssertEqual(request.method.queryItems?.count, 2)
        XCTAssertTrue(request.method.queryItems!.contains(expectedSinceID))
        XCTAssertTrue(request.method.queryItems!.contains(expectedLimit))
    }

    func testCreateWithMessage() {
        let request = Requests.Statuses.Create(status: "The most awesome status message ever!")

        // Endpoint
        XCTAssertEqual(request.path, "/api/v1/statuses")

        // Method
        XCTAssertEqual(request.method.name, "POST")
        XCTAssertNil(request.method.queryItems)
        XCTAssertNotNil(request.method.httpBody)

        let payload = String(data: request.method.httpBody!, encoding: .utf8)!
        XCTAssertEqual(payload.components(separatedBy: "&").count, 2)
        XCTAssertTrue(payload.contains("status=The%20most%20awesome%20status%20message%20ever%21"))
        XCTAssertTrue(payload.contains("visibility=public"))
    }

    func testCreateWithMessageAndReplyID() {
        let request = Requests.Statuses.Create(status: "The most awesome status message ever!", replyToID: "42")

        // Endpoint
        XCTAssertEqual(request.path, "/api/v1/statuses")

        // Method
        XCTAssertEqual(request.method.name, "POST")
        XCTAssertNil(request.method.queryItems)
        XCTAssertNotNil(request.method.httpBody)

        let payload = String(data: request.method.httpBody!, encoding: .utf8)!
        XCTAssertEqual(payload.components(separatedBy: "&").count, 3)
        XCTAssertTrue(payload.contains("status=The%20most%20awesome%20status%20message%20ever%21"))
        XCTAssertTrue(payload.contains("in_reply_to_id=42"))
        XCTAssertTrue(payload.contains("visibility=public"))
    }

    func testCreateWithMessageAndMediaIDs() {
        let request = Requests.Statuses.Create(status: "The most awesome status message ever!", mediaIDs: ["1", "2", "42"])

        // Endpoint
        XCTAssertEqual(request.path, "/api/v1/statuses")

        // Method
        XCTAssertEqual(request.method.name, "POST")
        XCTAssertNil(request.method.queryItems)
        XCTAssertNotNil(request.method.httpBody)

        let payload = String(data: request.method.httpBody!, encoding: .utf8)!
        XCTAssertEqual(payload.components(separatedBy: "&").count, 5)
        XCTAssertTrue(payload.contains("status=The%20most%20awesome%20status%20message%20ever%21"))
        XCTAssertTrue(payload.contains("visibility=public"))
        XCTAssertTrue(payload.contains("media_ids[]=1"))
        XCTAssertTrue(payload.contains("media_ids[]=2"))
        XCTAssertTrue(payload.contains("media_ids[]=42"))
    }

    func testCreateWithSensitiveMessage() {
        let request = Requests.Statuses.Create(status: "The most awesome status message ever!", sensitive: true)

        // Endpoint
        XCTAssertEqual(request.path, "/api/v1/statuses")

        // Method
        XCTAssertEqual(request.method.name, "POST")
        XCTAssertNil(request.method.queryItems)
        XCTAssertNotNil(request.method.httpBody)

        let payload = String(data: request.method.httpBody!, encoding: .utf8)!
        XCTAssertEqual(payload.components(separatedBy: "&").count, 3)
        XCTAssertTrue(payload.contains("status=The%20most%20awesome%20status%20message%20ever%21"))
        XCTAssertTrue(payload.contains("sensitive=true"))
        XCTAssertTrue(payload.contains("visibility=public"))
    }

    func testCreateWithSpoilerMessage() {
        let request = Requests.Statuses.Create(status: "Can't believe it's an amusement park like Westworld!", spoilerText: "Last night's GoT!!!")

        // Endpoint
        XCTAssertEqual(request.path, "/api/v1/statuses")

        // Method
        XCTAssertEqual(request.method.name, "POST")
        XCTAssertNil(request.method.queryItems)
        XCTAssertNotNil(request.method.httpBody)

        let payload = String(data: request.method.httpBody!, encoding: .utf8)!
        XCTAssertEqual(payload.components(separatedBy: "&").count, 3)
        XCTAssertTrue(payload.contains("status=Can%27t%20believe%20it%27s%20an%20amusement%20park%20like%20Westworld%21"))
        XCTAssertTrue(payload.contains("spoiler_text=Last%20night%27s%20GoT%21%21%21"))
        XCTAssertTrue(payload.contains("visibility=public"))
    }

    func testCreateWithUnlistedMessage() {
        let request = Requests.Statuses.Create(status: "The most awesome status message ever!", visibility: .unlisted)

        // Endpoint
        XCTAssertEqual(request.path, "/api/v1/statuses")

        // Method
        XCTAssertEqual(request.method.name, "POST")
        XCTAssertNil(request.method.queryItems)
        XCTAssertNotNil(request.method.httpBody)

        let payload = String(data: request.method.httpBody!, encoding: .utf8)!
        XCTAssertEqual(payload.components(separatedBy: "&").count, 2)
        XCTAssertTrue(payload.contains("status=The%20most%20awesome%20status%20message%20ever%21"))
        XCTAssertTrue(payload.contains("visibility=unlisted"))
    }

    func testDelete() {
        let request = Requests.Statuses.Delete(id: "42")

        // Endpoint
        XCTAssertEqual(request.path, "/api/v1/statuses/42")

        // Method
        XCTAssertEqual(request.method.name, "DELETE")
        XCTAssertNil(request.method.httpBody)
        XCTAssertNil(request.method.queryItems)
    }

    func testReblog() {
        let request = Requests.Statuses.Reblog(id: "42")

        // Endpoint
        XCTAssertEqual(request.path, "/api/v1/statuses/42/reblog")

        // Method
        XCTAssertEqual(request.method.name, "POST")
        XCTAssertNil(request.method.httpBody)
        XCTAssertNil(request.method.queryItems)
    }

    func testUnreblog() {
        let request = Requests.Statuses.Unreblog(id: "42")

        // Endpoint
        XCTAssertEqual(request.path, "/api/v1/statuses/42/unreblog")

        // Method
        XCTAssertEqual(request.method.name, "POST")
        XCTAssertNil(request.method.httpBody)
        XCTAssertNil(request.method.queryItems)
    }

    func testFavourite() {
        let request = Requests.Statuses.Favourite(id: "42")

        // Endpoint
        XCTAssertEqual(request.path, "/api/v1/statuses/42/favourite")

        // Method
        XCTAssertEqual(request.method.name, "POST")
        XCTAssertNil(request.method.httpBody)
        XCTAssertNil(request.method.queryItems)
    }

    func testUnfavourite() {
        let request = Requests.Statuses.Unfavourite(id: "42")

        // Endpoint
        XCTAssertEqual(request.path, "/api/v1/statuses/42/unfavourite")

        // Method
        XCTAssertEqual(request.method.name, "POST")
        XCTAssertNil(request.method.httpBody)
        XCTAssertNil(request.method.queryItems)
    }

    func testBookmark() {
        let request = Requests.Statuses.Bookmark(id: "42")

        // Endpoint
        XCTAssertEqual(request.path, "/api/v1/statuses/42/bookmark")

        // Method
        XCTAssertEqual(request.method.name, "POST")
        XCTAssertNil(request.method.httpBody)
        XCTAssertNil(request.method.queryItems)
    }

    func testUnbookmark() {
        let request = Requests.Statuses.Unbookmark(id: "42")

        // Endpoint
        XCTAssertEqual(request.path, "/api/v1/statuses/42/unbookmark")

        // Method
        XCTAssertEqual(request.method.name, "POST")
        XCTAssertNil(request.method.httpBody)
        XCTAssertNil(request.method.queryItems)
    }

    func testPin() {
        let request = Requests.Statuses.Pin(id: "42")

        // Endpoint
        XCTAssertEqual(request.path, "/api/v1/statuses/42/pin")

        // Method
        XCTAssertEqual(request.method.name, "POST")
        XCTAssertNil(request.method.httpBody)
        XCTAssertNil(request.method.queryItems)
    }

    func testUnpin() {
        let request = Requests.Statuses.Unpin(id: "42")

        // Endpoint
        XCTAssertEqual(request.path, "/api/v1/statuses/42/unpin")

        // Method
        XCTAssertEqual(request.method.name, "POST")
        XCTAssertNil(request.method.httpBody)
        XCTAssertNil(request.method.queryItems)
    }

    func testMute() {
        let request = Requests.Statuses.Mute(id: "42")

        // Endpoint
        XCTAssertEqual(request.path, "/api/v1/statuses/42/mute")

        // Method
        XCTAssertEqual(request.method.name, "POST")
        XCTAssertNil(request.method.httpBody)
        XCTAssertNil(request.method.queryItems)
    }

    func testUnmute() {
        let request = Requests.Statuses.Unmute(id: "42")

        // Endpoint
        XCTAssertEqual(request.path, "/api/v1/statuses/42/unmute")

        // Method
        XCTAssertEqual(request.method.name, "POST")
        XCTAssertNil(request.method.httpBody)
        XCTAssertNil(request.method.queryItems)
    }
}
