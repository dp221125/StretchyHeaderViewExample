//
//  SceneDelegate.swift
//  StretchyHeaderViewExample
//
//  Created by Seokho on 2020/01/17.
//  Copyright © 2020 Seokho. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        self.window = window
        
        let viewController = StretchyHeaderViewController()
        self.window?.rootViewController = viewController
        self.window?.makeKeyAndVisible()
    }
}
