//
//  ModelData.swift
//  FunWithDogs
//
//  Created by 정성훈 on 2021/10/14.
//

import Foundation

final class ModelData {
    var dogs: [Dog] = LocalData.load("dogFactData.json")
}

final class LocalData {
    static func load<T: Decodable>(_ filename: String) -> T {
        guard let file = Bundle.main.url(forResource: filename, withExtension: nil) else {
            fatalError("\(filename)을 메인 번들에서 찾을 수 없습니다.")
        }
        
        let data: Data
        do {
            data = try Data(contentsOf: file)
        } catch {
            fatalError("\(filename)을 메인번들에서 찾을 수 없습니다:\n\(error)")
        }
        
        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            fatalError("\(filename)을 \(T.self)로 파싱하지 못했습니다:\n\(error)")
        }
    }
}
