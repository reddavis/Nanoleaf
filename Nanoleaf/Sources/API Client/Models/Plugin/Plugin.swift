import Foundation

public struct Plugin {
    public var id: String
    public var name: String
    public var description: String
    public var author: String
    public var type: PluginType
    public var tags: [String]
    public var features: [String]
    public var config: [PluginConfiguration]?
    
    // MARK: Initialization
    
    init(
        id: String,
        name: String,
        description: String,
        author: String,
        type: PluginType,
        tags: [String],
        features: [String],
        config: [PluginConfiguration]? = nil
    ) {
        self.id = id
        self.name = name
        self.description = description
        self.author = author
        self.type = type
        self.tags = tags
        self.features = features
        self.config = config
    }
}

extension Plugin: Codable {}

// MARK: Coding keys

extension Plugin {
    enum CodingKeys: String, CodingKey {
        case id = "uuid"
        case name
        case description
        case author
        case type
        case tags
        case features
        case config = "pluginConfig"
    }
}

// MARK: Fixture

extension Plugin: Fixture {
    public static func fixture(_ configure: ((inout Self) -> Void)? = nil) -> Self {
        var fixture = Plugin(
            id: "1",
            name: "Plugin A",
            description: "This is a cool plugin.",
            author: "Red",
            type: .color,
            tags: ["cool", "disco"],
            features: ["feature A", "feature B"],
            config: [
                .bool(.init(name: "Bool config A", defaultValue: false)),
                .bool(.init(name: "Bool config B", defaultValue: false)),
                .string(.init(name: "String config A", defaultValue: "A", options: ["A", "B", "C"])),
                .int(.init(name: "Int config A", defaultValue: 1, minimumValue: 0, maximumValue: 5))
            ]
        )
        configure?(&fixture)
        return fixture
    }
}
