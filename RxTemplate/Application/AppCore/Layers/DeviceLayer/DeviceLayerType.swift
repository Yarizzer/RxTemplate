//
//  DeviceLayerType.swift
//  RxTemplate
//
//  Created by Yaroslav Abaturov on 11.02.2023.
//

import UIKit

protocol DeviceLayerType {
    var screenSize: CGRect { get }
    var hasTopNotch: Bool { get }
    
    func generateSuccessFeedback()
    func generateFailureFeedback()
    func vibrate()
}
