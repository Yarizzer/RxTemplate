//
//  DatabaseLayer.swift
//  RxTemplate
//
//  Created by Yaroslav Abaturov on 11.02.2023.
//

import RxSwift
import CoreData

class DatabaseLayer {
    init() {
        self.container = NSPersistentContainer(name: Constants.containerName)
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        
        self.context = container.viewContext
    }
    
    //MARK: - Context
    private func saveContext() {
        do {
            try context.save()
        } catch {
            writeLog(type: .coreDataError, message: error.localizedDescription)
        }
    }
    
    func prepareSession(completion: @escaping (Bool) -> ()) {
        let fetchRequest: NSFetchRequest<ItemEntity> = ItemEntity.fetchRequest()
            
        var value = [ItemModel]()
        do {
            try context.fetch(fetchRequest).forEach { entity in
                value.append(ItemModel(with: entity))
            }
        } catch {
            writeLog(type: .coreDataError, message: error.localizedDescription)
        }
        
        itemsPublisher.onNext(value)
    }
    
    var itemsPublisher: PublishSubject<[ItemModel]> = PublishSubject<[ItemModel]>()
    
    private let container: NSPersistentContainer
    private let context: NSManagedObjectContext
}

extension DatabaseLayer: DatabaseLayerType {
    
}

extension DatabaseLayer {
    private struct Constants {
        static let containerName = "RxTemplate"
        static let messageEntityName = "ItemEntity"
    }
}
