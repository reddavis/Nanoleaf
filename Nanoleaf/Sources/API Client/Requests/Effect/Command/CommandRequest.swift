import Foundation

public enum CommandRequest { }

// MARK: Fetch plugins

extension CommandRequest {
    public static func fetchPlugins(
        url: URL,
        token: String
    ) throws -> ExecuteCommandRequest<FetchPluginsBody> {
        try ExecuteCommandRequest<FetchPluginsBody>(
            url: url,
            token: token,
            command: .fetchPlugins
        )
    }
    
    // MARK: Body
    
    public struct FetchPluginsBody: Codable {
        public var plugins: [Plugin]
    }
}

// MARK: Fetch effects

extension CommandRequest {
    public static func fetchEffects(
        url: URL,
        token: String
    ) throws -> ExecuteCommandRequest<FetchEffectsBody> {
        try ExecuteCommandRequest<FetchEffectsBody>(
            url: url,
            token: token,
            command: .fetchEffects
        )
    }
    
    // MARK: Body
    
    public struct FetchEffectsBody: Codable {
        public var animations: [Effect]
    }
}

// MARK: Rename effect

extension CommandRequest {
    public static func renameEffect(
        url: URL,
        token: String,
        name: String,
        newName: String
    ) throws -> ExecuteCommandRequest<Empty> {
        try ExecuteCommandRequest<Empty>(
            url: url,
            token: token,
            command: .renameEffect(name: name, newName: newName)
        )
    }
}

public struct Empty: Codable {}
