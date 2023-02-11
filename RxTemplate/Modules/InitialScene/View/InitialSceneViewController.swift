//
//  InitialSceneViewController.swift
//  RxTemplate
//
//  Created by Yaroslav Abaturov on 11.02.2023.
//  Copyright (c) 2023 Yaroslav Abaturov. All rights reserved.
//

import UIKit

class InitialSceneViewController: BaseViewController<InitialSceneInteractable> {
	// MARK: View lifecycle
	override func viewDidLoad() {
		super.viewDidLoad()
		
		setup()
	}
	
	private func setup() {
		interactor?.makeRequest(requestType: .initialSetup)
	}
    
    
    @IBOutlet private weak var sceneTitle: UILabel!
}

extension InitialSceneViewController: InitialSceneViewControllerType {
	func update(viewModelDataType: InitialSceneViewControllerViewModel.ViewModelDataType) {
		switch viewModelDataType {
		case .initialSetup(let model):
            sceneTitle.text = model.sceneTitle
		}
	}
}

extension InitialSceneViewController {
	private struct Constants {
		
	}
}
