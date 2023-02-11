//
//  AppCore.swift
//  RxTemplate
//
//  Created by Yaroslav Abaturov on 11.02.2023.
//

import Foundation

class AppCore {
    static let shared = AppCore()
    
    private init() {
        self.appDatabaseLayer = DatabaseLayer()
        self.appDeviceLayer = DeviceLayer()
        self.appStyleLayer = StyleLayer()
    }
    
    func prepareSession() {}
    func runSession() {}
    func closeSession() {}
    
    private let appDatabaseLayer: DatabaseLayerType
    private let appDeviceLayer: DeviceLayerType
    private let appStyleLayer: StyleLayerType
}

extension AppCore: AppCoreDeviceLayerType {
    var deviceLayer: DeviceLayerType { return appDeviceLayer }
}

extension AppCore: AppCoreDatabaseLayerType {
    var databaseLayer: DatabaseLayerType { return appDatabaseLayer }
}

extension AppCore: AppCoreStyleLayerType {
    var styleLayer: StyleLayerType { return appStyleLayer }
}
