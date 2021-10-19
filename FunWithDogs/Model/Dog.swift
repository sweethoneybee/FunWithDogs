//
//  DogFact.swift
//  FunWithDogs
//
//  Created by 정성훈 on 2021/10/14.
//

import Foundation

struct Dog: Decodable, Hashable {
    let fact: String
    let identifier = UUID()
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
    
    static func == (lhs: Dog, rhs: Dog) -> Bool {
        return lhs.identifier == rhs.identifier
    }
}
