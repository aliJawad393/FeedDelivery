//
//  SceneDelegate.swift
//  FoodDelivery
//
//  Created by Ali Jawad on 07/09/2021.
//

import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        let navigationController = UINavigationController()
        let factory = iOSUIKitViewControllerFactory(navigationController: navigationController)
        navigationController.viewControllers = [factory.createItemsListVC()]
        navigationController.isNavigationBarHidden = true
        window?.windowScene = windowScene
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}

