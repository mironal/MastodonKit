//
//  TimelinesTests.swift
//  MastodonKit
//
//  Created by Ornithologist Coder on 5/17/17.
//  Copyright © 2017 MastodonKit. All rights reserved.
//

import XCTest
@testable import MastodonKit

class TimelinesTests: XCTestCase {
    func testHomeTimeline() {
        let request = Requests.Timelines.Home()

        // Endpoint
        XCTAssertEqual(request.path, "/api/v1/timelines/home")

        // Method
        XCTAssertEqual(request.method.name, "GET")
        XCTAssertNil(request.method.queryItems)
        XCTAssertNil(request.method.httpBody)
    }

    func testHomeTimelineWithRange() {
        let request = Requests.Timelines.Home(range: .limit(32))
        let expectedLimit = URLQueryItem(name: "limit", value: "32")

        // Endpoint
        XCTAssertEqual(request.path, "/api/v1/timelines/home")

        // Method
        XCTAssertEqual(request.method.name, "GET")
        XCTAssertNil(request.method.httpBody)
        XCTAssertEqual(request.method.queryItems?.count, 1)
        XCTAssertTrue(request.method.queryItems!.contains(expectedLimit))
    }

    func testPublicTimelineLocal() {
        let request = Requests.Timelines.Public(local: true)

        // Endpoint
        XCTAssertEqual(request.path, "/api/v1/timelines/public")

        // Method
        XCTAssertEqual(request.method.name, "GET")
        XCTAssertNil(request.method.httpBody)
        XCTAssertTrue(request.method.queryItems!.contains(URLQueryItem(name: "local", value: "true")))
    }

    func testPublicTimelineFederated() {
        let request = Requests.Timelines.Public()

        // Endpoint
        XCTAssertEqual(request.path, "/api/v1/timelines/public")

        // Method
        XCTAssertEqual(request.method.name, "GET")
        XCTAssertNil(request.method.httpBody)
        XCTAssertEqual(request.method.queryItems?.count, 0)
    }

    func testPublicTimelineLocalWithRange() {
        let request = Requests.Timelines.Public(local: true, range: .since(id: "420", limit: 12))
        let expectedLocal = URLQueryItem(name: "local", value: "true")
        let expectedLimit = URLQueryItem(name: "limit", value: "12")
        let expectedSinceID = URLQueryItem(name: "since_id", value: "420")

        // Endpoint
        XCTAssertEqual(request.path, "/api/v1/timelines/public")

        // Method
        XCTAssertEqual(request.method.name, "GET")
        XCTAssertNil(request.method.httpBody)
        XCTAssertEqual(request.method.queryItems!.count, 3)
        XCTAssertTrue(request.method.queryItems!.contains(expectedLocal))
        XCTAssertTrue(request.method.queryItems!.contains(expectedLimit))
        XCTAssertTrue(request.method.queryItems!.contains(expectedSinceID))
    }

    func testTagTimelineLocal() {
        let request = Requests.Timelines.Tag("mastodonkit", local: true)

        // Endpoint
        XCTAssertEqual(request.path, "/api/v1/timelines/tag/mastodonkit")

        // Method
        XCTAssertEqual(request.method.name, "GET")
        XCTAssertNil(request.method.httpBody)
        XCTAssertTrue(request.method.queryItems!.contains(URLQueryItem(name: "local", value: "true")))
    }

    func testTagTimelineFederated() {
        let request = Requests.Timelines.Tag("mastodonkit")

        // Endpoint
        XCTAssertEqual(request.path, "/api/v1/timelines/tag/mastodonkit")

        // Method
        XCTAssertEqual(request.method.name, "GET")
        XCTAssertNil(request.method.httpBody)
        XCTAssertEqual(request.method.queryItems?.count, 0)
    }

    func testTagTimelineWithRange() {
        let request = Requests.Timelines.Tag("mastodonkit", range: .since(id: "420", limit: 12))
        let expectedLimit = URLQueryItem(name: "limit", value: "12")
        let expectedSinceID = URLQueryItem(name: "since_id", value: "420")

        // Endpoint
        XCTAssertEqual(request.path, "/api/v1/timelines/tag/mastodonkit")

        // Method
        XCTAssertEqual(request.method.name, "GET")
        XCTAssertNil(request.method.httpBody)
        XCTAssertEqual(request.method.queryItems!.count, 2)
        XCTAssertTrue(request.method.queryItems!.contains(expectedLimit))
        XCTAssertTrue(request.method.queryItems!.contains(expectedSinceID))
    }
}
