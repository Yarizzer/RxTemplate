//
//  BaseViewController.swift
//  RxTemplate
//
//  Created by Yaroslav Abaturov on 11.02.2023.
//

import UIKit

class BaseViewController<IntreactorT>: UIViewController {
    override func viewDidLoad() { super.viewDidLoad() }
    
    var interactor: IntreactorT?
}
