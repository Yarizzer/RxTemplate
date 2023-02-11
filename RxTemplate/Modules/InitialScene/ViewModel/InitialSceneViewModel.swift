//
//  InitialSceneViewModel.swift
//  RxTemplate
//
//  Created by Yaroslav Abaturov on 11.02.2023.
//  Copyright (c) 2023 Yaroslav Abaturov. All rights reserved.
//

protocol InitialSceneViewModelType {
    var sceneTitle: String { get }
}

class InitialSceneViewModel {
	
}

extension InitialSceneViewModel: InitialSceneViewModelType {
    var sceneTitle: String { return Constants.sceneTitle }
}

extension InitialSceneViewModel {
    private struct Constants {
        static let sceneTitle = "Initial scene"
    }
}
