import Foundation

/// A protocol to give Enums the ability to provide an `unknown` case which.
protocol UnknownCaseRepresentable: RawRepresentable, CaseIterable where RawValue: Equatable {
    static var unknownCase: Self { get }
}

// MARK: Default implementations

extension UnknownCaseRepresentable {
    // MARK: Initialization
    
    init(rawValue: RawValue) {
        let value = Self.allCases.first { currentCase -> Bool in
            return currentCase.rawValue == rawValue
        }
        
        self = value ?? Self.unknownCase
    }
    
    init(rawValue: RawValue?) {
        guard let rawValue = rawValue else {
            self = Self.unknownCase
            return
        }
        
        let value = Self.allCases.first { $0.rawValue == rawValue }
        self = value ?? Self.unknownCase
    }
}
