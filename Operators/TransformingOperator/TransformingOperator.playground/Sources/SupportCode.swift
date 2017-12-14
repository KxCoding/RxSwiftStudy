import Foundation

public func example(_ description: String, action: () -> Void) {
    print("\n###  \(description)  ###")
    action()
}


public enum Error: Swift.Error {
    case error
}
