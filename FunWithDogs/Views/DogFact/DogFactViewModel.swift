//
//  DogFactViewModel.swift
//  FunWithDogs
//
//  Created by 정성훈 on 2021/10/16.
//

import Foundation
import Alamofire

final class DogFactViewModel {
    init(modelData: ModelData = ModelData()) {
        self.dogs = modelData.dogs
        
        self.dogFact = UserManager.latestDogFact ?? dogs[Int.random(in: 0..<dogs.count)].fact
        self.dogImageData = UserManager.latestDogImageData
    }
    
    private let dogs: [Dog]
    private var dogImageURL: URL?
    
    var dogImageData: Data? {
        didSet {
            UserManager.latestDogImageData = dogImageData
            dogImageDataDidChange?(dogImageData)
        }
    }
    
    var dogFact: String {
        didSet {
            UserManager.latestDogFact = dogFact
            dogFactDidChange?(dogFact)
        }
    }
    
    var dogFactDidChange: ((String) -> ())?
    var dogImageDataDidChange: ((Data?) -> ())?
    
    func refreshDog(previousFact: String, completionHander: (()->())? = nil) {
        var data: Data?
        let fetchGroup = DispatchGroup()
        
        fetchGroup.enter()
        AF.request("https://dog.ceo/api/breeds/image/random")
            .validate()
            .responseDecodable(of: DogPicture.self) { response in
                guard let imageURL = response.value?.message else {
                    fetchGroup.leave()
                    return
                }
                
                AF.download(imageURL)
                    .responseData { response in
                        data = response.value
                        fetchGroup.leave()
                    }
            }
        
        var randomFact = previousFact
        var roopCount = 0
        while randomFact == previousFact,
              roopCount < 10 {
            randomFact = dogs[Int.random(in: 0..<dogs.count)].fact
            roopCount += 1
        }
        
        fetchGroup.notify(queue: .main) {
            self.dogImageData = data
            self.dogFact = randomFact
            UserManager.readFactCount += 1
            completionHander?()
        }
    }
}

