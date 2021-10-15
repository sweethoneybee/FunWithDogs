//
//  UserManager.swift
//  FunWithDogs
//
//  Created by 정성훈 on 2021/10/14.
//

import Foundation

@propertyWrapper
struct UserDefault<T> {
    var key: String
    let defaultValue: T
    
    var wrappedValue: T {
        get {
            UserDefaults.standard.object(forKey: key) as? T ?? defaultValue
        }
        set {
            UserDefaults.standard.set(newValue, forKey: key)
        }
    }
}

final class UserManager {
    @UserDefault(key: "readDogFactCount", defaultValue: 0)
    static var readFactCount: Int
    
    @UserDefault(key: "latestDogFact", defaultValue: nil)
    static var latestDogFact: String?
    
    @UserDefault(key: "latestDogImageURL", defaultValue: nil)
    static var latestDogImageURL: String?
    
    @UserDefault(key: "latestDogImageData", defaultValue: nil)
    static var latestDogImageData: Data?
}
