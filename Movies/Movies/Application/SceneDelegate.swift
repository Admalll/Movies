// SceneDelegate.swift
// Copyright © Roadmap. All rights reserved.

import UIKit
class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) { guard let windowScene = (scene as? UIWindowScene) else { return }

        let vc = MoviesViewController()
        let navigation = UINavigationController(rootViewController: vc)

        window?.windowScene = windowScene
        window?.rootViewController = navigation
        window?.makeKeyAndVisible()
    }
}
