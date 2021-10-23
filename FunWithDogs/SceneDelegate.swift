//
//  SceneDelegate.swift
//  FunWithDogs
//
//  Created by 정성훈 on 2021/10/11.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        
        let dogFactVC = DogFactViewController(viewModel: DogFactViewModel())
        let nvc = UINavigationController(rootViewController: dogFactVC)
        
        if UserManager.isFirstLaunched {
            UserManager.isFirstLaunched = false
            let startVC = StartViewController()
            startVC.navigationItem.hidesBackButton = true
            nvc.pushViewController(startVC, animated: false)
        }
        
        window?.rootViewController = nvc
        window?.makeKeyAndVisible()
    }
}
