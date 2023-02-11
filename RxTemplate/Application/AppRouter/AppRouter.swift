//
//  AppRouter.swift
//  RxTemplate
//
//  Created by Yaroslav Abaturov on 11.02.2023.
//

import UIKit

protocol AppRoutable {
    func routeToInitialScene()
}

class AppRouter {
    init() {
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.backgroundColor = .systemBackground
        self.window = window
    }
    
    private var window: UIWindow
}

extension AppRouter: AppRoutable {
    func routeToInitialScene() {
        window.rootViewController = InitialSceneRouter.assembly()
        window.makeKeyAndVisible()
    }
}
