//
//  ItemModel.swift
//  RxTemplate
//
//  Created by Yaroslav Abaturov on 12.02.2023.
//

import Foundation

struct ItemModel {
    init(with entity: ItemEntity) {
        self.uid            = entity.uid
        self.title          = entity.title
        self.lastSelected   = entity.lastSelected
    }
    
    var uid: UUID
    var title: String
    var lastSelected: Bool
}
