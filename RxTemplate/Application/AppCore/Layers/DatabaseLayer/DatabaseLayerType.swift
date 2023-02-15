//
//  DatabaseLayerType.swift
//  RxTemplate
//
//  Created by Yaroslav Abaturov on 11.02.2023.
//

import RxSwift

protocol DatabaseLayerType {
    func prepareSession(completion: @escaping (Bool) -> ())
    
    var itemsPublisher: PublishSubject<[ItemModel]> { get }
    
    func createNewItem(with data: ItemModel)
    func removeAllItems()
}
