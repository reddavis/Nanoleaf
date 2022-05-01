import Foundation

#if os(iOS) || os(tvOS) || os(watchOS)
import UIKit
public typealias Color = UIColor
#elseif os(OSX)
import Cocoa
public typealias Color = NSColor
#endif
