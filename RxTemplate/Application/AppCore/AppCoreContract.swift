//
//  AppCoreContract.swift
//  RxTemplate
//
//  Created by Yaroslav Abaturov on 11.02.2023.
//

protocol AppCoreStyleLayerType {
    var styleLayer: StyleLayerType { get }
}

protocol AppCoreDeviceLayerType {
    var deviceLayer: DeviceLayerType { get }
}

protocol AppCoreDatabaseLayerType {
    var databaseLayer: DatabaseLayerType { get }
}
