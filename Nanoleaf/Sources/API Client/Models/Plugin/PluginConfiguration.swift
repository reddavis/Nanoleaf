import Foundation

public enum PluginConfiguration {
    case bool(BoolConfiguration)
    case int(IntConfiguration)
    case string(StringConfiguration)
}

// MARK: Codable

extension PluginConfiguration: Codable {
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let type = try container.decode(PluginConfigurationType.self, forKey: .type)
        
        switch type
        {
        case .int:
            let configuration = try IntConfiguration(from: decoder)
            self = .int(configuration)
        case .bool:
            let configuration = try BoolConfiguration(from: decoder)
            self = .bool(configuration)
        case .string:
            let configuration = try StringConfiguration(from: decoder)
            self = .string(configuration)
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.unkeyedContainer()
        switch self {
        case .bool(let configuration):
            try container.encode(configuration)
        case .string(let configuration):
            try container.encode(configuration)
        case .int(let configuration):
            try container.encode(configuration)
        }
    }
}

// MARK: Coding keys

extension PluginConfiguration {
    enum CodingKeys: String, CodingKey {
        case type
    }
}

// MARK: Plugin configuration type

public enum PluginConfigurationType: String {
    case int
    case bool
    case string
}

extension PluginConfigurationType: Codable {}

// MARK: Bool configuration

extension PluginConfiguration {
    public struct BoolConfiguration {
        public var type: PluginConfigurationType = .bool
        public var name: String
        public var defaultValue: Bool
    }
}

extension PluginConfiguration.BoolConfiguration: Codable {}

// MARK: String configuration

extension PluginConfiguration {
    public struct StringConfiguration {
        public var type: PluginConfigurationType = .string
        public var name: String
        public var defaultValue: String
        public var options: [String]
    }
}

extension PluginConfiguration.StringConfiguration: Codable {}

// MARK: Coding keys

extension PluginConfiguration.StringConfiguration {
    enum CodingKeys: String, CodingKey {
        case type
        case name
        case defaultValue
        case options = "strings"
    }
}

// MARK: Int configuration

extension PluginConfiguration {
    public struct IntConfiguration {
        public var type: PluginConfigurationType = .int
        public var name: String
        public var defaultValue: Int
        public var minimumValue: Int
        public var maximumValue: Int
    }
}

extension PluginConfiguration.IntConfiguration: Codable {}

// MARK: Coding keys

extension PluginConfiguration.IntConfiguration {
    enum CodingKeys: String, CodingKey {
        case type
        case name
        case defaultValue
        case minimumValue = "minValue"
        case maximumValue = "maxValue"
    }
}
