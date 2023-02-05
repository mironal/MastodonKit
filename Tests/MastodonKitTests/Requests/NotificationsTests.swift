//
//  NotificationsTests.swift
//  MastodonKit
//
//  Created by Ornithologist Coder on 5/17/17.
//  Copyright © 2017 MastodonKit. All rights reserved.
//

import XCTest
@testable import MastodonKit

class NotificationsTests: XCTestCase {
    func testAll() {
        let request = MastodonRequests.Notifications.All()

        // Endpoint
        XCTAssertEqual(request.path, "/api/v1/notifications")

        // Method
        XCTAssertEqual(request.method.name, "GET")
        XCTAssertNil(request.method.queryItems)
        XCTAssertNil(request.method.httpBody)
    }

    func testAllWithRange() {
        let request = MastodonRequests.Notifications.All(range: .max(id: "123", limit: 12))
        let expectedMaxID = URLQueryItem(name: "max_id", value: "123")
        let expectedLimit = URLQueryItem(name: "limit", value: "12")

        // Endpoint
        XCTAssertEqual(request.path, "/api/v1/notifications")

        // Method
        XCTAssertEqual(request.method.name, "GET")
        XCTAssertNil(request.method.httpBody)
        XCTAssertEqual(request.method.queryItems?.count, 2)
        XCTAssertTrue(request.method.queryItems!.contains(expectedMaxID))
        XCTAssertTrue(request.method.queryItems!.contains(expectedLimit))
    }

    func testNotification() {
        let request = MastodonRequests.Notifications.NotificationBy(id: "42")

        // Endpoint
        XCTAssertEqual(request.path, "/api/v1/notifications/42")

        // Method
        XCTAssertEqual(request.method.name, "GET")
        XCTAssertNil(request.method.queryItems)
        XCTAssertNil(request.method.httpBody)
    }

    func testDismissAll() {
        let request = MastodonRequests.Notifications.DismissAll()

        // Endpoint
        XCTAssertEqual(request.path, "/api/v1/notifications/clear")

        // Method
        XCTAssertEqual(request.method.name, "POST")
        XCTAssertNil(request.method.queryItems)
        XCTAssertNil(request.method.httpBody)
    }

    func testDismissWithID() {
        let request = MastodonRequests.Notifications.Dismiss(id: "42")

        // Endpoint
        XCTAssertEqual(request.path, "/api/v1/notifications/dismiss")

        // Method
        XCTAssertEqual(request.method.name, "POST")
        XCTAssertNil(request.method.queryItems)
        XCTAssertNotNil(request.method.httpBody)

        let payload = String(data: request.method.httpBody!, encoding: .utf8)!
        XCTAssertEqual(payload.components(separatedBy: "&").count, 1)
        XCTAssertTrue(payload.contains("id=42"))
    }
}
