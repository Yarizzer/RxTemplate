//
//  AppDelegate.swift
//  RxTemplate
//
//  Created by Yaroslav Abaturov on 11.02.2023.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    private var router: AppRoutable?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        router = AppRouter()
        
        AppCore.shared.prepareSession()
        
        routeToInitialScene()
        
        return true
    }

    private func routeToInitialScene() {
        self.router?.routeToInitialScene()
    }
}
