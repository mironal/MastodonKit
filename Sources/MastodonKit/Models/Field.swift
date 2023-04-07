import Foundation

public struct Field: Codable, Hashable {

    /// The key of a given field’s key-value pair.
    public let name: String

    /// The value associated with the name key.
    public let value: String

    public let verifiedAt: Date?

    public init(name: String, value: String, verifiedAt: Date?) {
        self.name = name
        self.value = value
        self.verifiedAt = verifiedAt
    }

    private enum CodingKeys: String, CodingKey {
        case name
        case value
        case verifiedAt = "verified_at"
    }
}
