//
//  DataModel.swift
//  Model
//
//  Created by Mohit Kumar Singh on 11/07/23.
//

import Foundation

/// User Default Keys
private struct UserDefaultConfigKey {
}

/// Singleton Class: DataModel
///  For accessing, saving and updating user default values
class DataModel {
    
    /// Single Shared Instance
    static let shared = DataModel()
    
    /// Private init to prevent external initialization
    private init() {}
    
    
}

@propertyWrapper
/// Property Wrapper for User Defaults to provide default value
public struct UserDefault<T> {
    
    let key: String
    let defaultValue: T
    
    init(_ key: String, _ defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue
    }
    
    public var wrappedValue: T {
        get {
            return UserDefaults.standard.object(forKey: key) as? T ?? defaultValue
        } set {
            UserDefaults.standard.set(newValue, forKey: key)
            UserDefaults.standard.synchronize()
        }
    }
}

extension UserDefault where T: ExpressibleByNilLiteral {
    init(_ key: String) {
        self.init(key, nil)
    }
}
