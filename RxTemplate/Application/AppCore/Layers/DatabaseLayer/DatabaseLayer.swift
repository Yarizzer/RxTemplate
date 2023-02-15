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
    func createNewItem(with data: ItemModel) {
        guard let entity = NSEntityDescription.entity(forEntityName: Constants.messageEntityName, in: context),
              let entityObject = NSManagedObject(entity: entity, insertInto: context) as? ItemEntity else { return }
        
        entityObject.title = data.title
        entityObject.lastSelected = data.lastSelected
        entityObject.uid = data.uid
                
        saveContext()
    }
    
    func removeAllItems() {
        let fetchRequest: NSFetchRequest<ItemEntity> = ItemEntity.fetchRequest()
                
        do {
            let result = try context.fetch(fetchRequest)
            result.forEach { context.delete($0) }
            
            try context.save()
        } catch {
            writeLog(type: .coreDataError, message: error.localizedDescription)
        }
    }
}

extension DatabaseLayer {
    private struct Constants {
        static let containerName = "RxTemplate"
        static let messageEntityName = "ItemEntity"
    }
}
