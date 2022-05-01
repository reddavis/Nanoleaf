import Foundation

struct Command {
    var version = "2.0"
    var type: CommandType
    var name: String? = nil
    var newName: String? = nil
    var duration: TimeInterval? = nil
}

extension Command: Codable {}

// MARK: Coding keys

extension Command {
    enum CodingKeys: String, CodingKey {
        case version
        case type = "command"
        case name = "animName"
        case newName = "newName"
    }
}

// MARK: Helpers

extension Command {
    static func deleteEffect(name: String) -> Command {
        .init(
            type: .deleteEffect,
            name: name
        )
    }
    
    static func displayEffectTemporarily(
        name: String,
        duration: TimeInterval
    ) -> Command {
        .init(
            type: .displayEffectTemporarily,
            name: name,
            duration: duration
        )
    }
    
    static var fetchPlugins: Command {
        .init(type: .fetchPlugins)
    }
    
    static var fetchEffects: Command {
        .init(type: .fetchEffects)
    }
    
    static func renameEffect(
        name: String,
        newName: String
    ) -> Command {
        .init(
            type: .renameEffect,
            name: name,
            newName: newName
        )
    }
}

// MARK: Command type

enum CommandType: String, Codable {
    /// Add will add (or update) an effect to the device and update the effect list.
    /// If the effect already exists, issuing this command will overwrite the previous effect.
    case addEffect = "add"
    
    /// Fetch effect data from the device for a particular effect.
    case fetchEffect = "request"
    
    /// Fetch all the effect data from the device.
    case fetchEffects = "requestAll"
    
    /// Delete an effect.
    case deleteEffect = "delete"
    
    /// Display is used to see a preview on the device.
    /// This functions as a way to temporary display an effect on the device without
    /// saving as an effect.
    case displayPreview = "display"
    
    /// Rename an effect.
    case renameEffect = "rename"
    
    /// Temporarily set an effect on the device.
    /// This is typically used for temporary notifications or visual indicators.
    case displayEffectTemporarily = "displayTemp"
    
    /// Request plugin data from the device.
    case fetchPlugins = "requestPlugins"
}
