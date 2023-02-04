//
//  Media.swift
//  MastodonKit
//
//  Created by Ornithologist Coder on 5/9/17.
//  Copyright © 2017 MastodonKit. All rights reserved.
//

import Foundation

extension MastodonRequests {
    /// `Media` requests.
    public enum Media {
        /// Uploads a media attachment.
        open class Upload: RequestBase<Attachment> {
            /// - Parameter mediaAttachment: The media attachment to upload.
            public init(media mediaAttachment: MediaAttachment) {
                super.init(path: "/api/v1/media", method: .post(.media(mediaAttachment)))
            }
        }
    }
}
