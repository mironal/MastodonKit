//
//  Attachment.swift
//  MastodonKit
//
//  Created by Ornithologist Coder on 4/9/17.
//  Copyright © 2017 MastodonKit. All rights reserved.
//

import Foundation

public struct  Attachment: Codable, Hashable {
    /// ID of the attachment.
    public let id: String
    /// Type of the attachment.
    public let type: AttachmentType
    /// URL of the locally hosted version of the image.
    public let url: String
    /// For remote images, the remote URL of the original image.
    public let remoteURL: String?
    /// URL of the preview image.
    public let previewURL: String?
    /// Shorter URL for the image, for insertion into text (only present on local images).
    public let textURL: String?
    /// A description of the image for the visually impaired.
    public let description: String?
    /// A free-form object that might contain information about the attachment.
    public let meta: Meta?

    public struct Meta: Codable, Hashable {
        public struct Info: Codable, Hashable {
            public let width: Int?
            public let height: Int?
            public let size: String?
            public let aspect: Double?
            public let frameRate: String?
            public let duration: Double?
            public let bitrate: Int?

            public init(width: Int? = nil, height: Int? = nil, size: String? = nil, aspect: Double? = nil, frameRate: String? = nil, duration: Double? = nil, bitrate: Int? = nil) {
                self.width = width
                self.height = height
                self.size = size
                self.aspect = aspect
                self.frameRate = frameRate
                self.duration = duration
                self.bitrate = bitrate
            }

            private enum CodingKeys: String, CodingKey {
                case width
                case height
                case size
                case aspect
                case frameRate = "frame_rate"
                case duration
                case bitrate
            }
        }

        public struct Focus: Codable, Hashable {
            public var x: Double
            public var y: Double

            public init(x: Double, y: Double) {
                self.x = x
                self.y = y
            }
        }

        public let original: Info?
        public let small: Info?
        public let focus: Focus?

        public init(original: Info? = nil, small: Info? = nil, focus: Focus? = nil) {
            self.original = original
            self.small = small
            self.focus = focus
        }
    }

    private enum CodingKeys: String, CodingKey {
        case id
        case type
        case url
        case remoteURL = "remote_url"
        case previewURL = "preview_url"
        case textURL = "text_url"
        case description
        case meta
    }
}
