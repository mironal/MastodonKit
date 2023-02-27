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

    func testPublicTimelineRemote() {
        let request = Requests.Timelines.Public(remote: true)
        let expectedRemote = URLQueryItem(name: "remote", value: "true")

        // Endpoint
        XCTAssertEqual(request.path, "/api/v1/timelines/public")

        // Method
        XCTAssertEqual(request.method.name, "GET")
        XCTAssertNil(request.method.httpBody)
        XCTAssertEqual(request.method.queryItems!.count, 1)
        XCTAssertTrue(request.method.queryItems!.contains(expectedRemote))
    }

    func testPublicTimelineOnlyMedia() {
        let request = Requests.Timelines.Public(onlyMedia: true)
        let expectedOnlyMedia = URLQueryItem(name: "only_media", value: "true")

        // Endpoint
        XCTAssertEqual(request.path, "/api/v1/timelines/public")

        // Method
        XCTAssertEqual(request.method.name, "GET")
        XCTAssertNil(request.method.httpBody)
        XCTAssertEqual(request.method.queryItems!.count, 1)
        XCTAssertTrue(request.method.queryItems!.contains(expectedOnlyMedia))
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

    func testTagTimelineOnlyMedia() {
        let request = Requests.Timelines.Tag("mastodonkit", onlyMedia: true)
        let expectedOnlyMedia = URLQueryItem(name: "only_media", value: "true")

        // Endpoint
        XCTAssertEqual(request.path, "/api/v1/timelines/tag/mastodonkit")

        // Method
        XCTAssertEqual(request.method.name, "GET")
        XCTAssertNil(request.method.httpBody)
        XCTAssertEqual(request.method.queryItems?.count, 1)
        XCTAssertTrue(request.method.queryItems!.contains(expectedOnlyMedia))
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


    func testListTimeline() {
        let request = Requests.Timelines.List("123")

        // Endpoint
        XCTAssertEqual(request.path, "/api/v1/timelines/list/123")

        // Method
        XCTAssertEqual(request.method.name, "GET")
        XCTAssertNil(request.method.httpBody)
        XCTAssertEqual(request.method.queryItems!.count, 0)
    }

    func testListTimelineWithRange() {
        let request = Requests.Timelines.List("123", range: .min(id: "30", limit: 22))
        let expectedLimit = URLQueryItem(name: "limit", value: "22")
        let expectedMinID = URLQueryItem(name: "min_id", value: "30")

        // Endpoint
        XCTAssertEqual(request.path, "/api/v1/timelines/list/123")

        // Method
        XCTAssertEqual(request.method.name, "GET")
        XCTAssertNil(request.method.httpBody)
        XCTAssertEqual(request.method.queryItems!.count, 2)
        XCTAssertTrue(request.method.queryItems!.contains(expectedLimit))
        XCTAssertTrue(request.method.queryItems!.contains(expectedMinID))
    }
}
