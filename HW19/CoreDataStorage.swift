//
//  CoreDataStorage.swift
//  HW19
//
//  Created by Павел on 11.03.2023.
//

import Foundation
import CoreData

final class CoreDataStorage {
    
    static let shared = CoreDataStorage()
    private lazy var context: NSManagedObjectContext = persistentContainer.viewContext
    
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Model")
        container.loadPersistentStores { _ , error in
            if let error = error {
                print(error)
            }
        }
        return container
    }()
    private init() {
    }
    
}

extension CoreDataStorage {
    func getExecutor() -> [Executor] {
        let fetchRequest = Executor.fetchRequest()
        do {
            let executors = try context.fetch(fetchRequest)
            return executors
        } catch {
            print(error)
        }
        return []
    }
    
    func saveExecutor(_ executor: ExecutorViewModel) {

        let saveExecutor = getExecutor()
        if let savedExecutor = saveExecutor.first( where: { $0.id == executor.id}) {
            savedExecutor.name = executor.name
            savedExecutor.surname = executor.surname
            savedExecutor.age = Int16(executor.age)
            savedExecutor.country = executor.country
        } else {
            guard let entity = NSEntityDescription.entity(forEntityName: "Executor", in: context) else {
                return
            }
            let newExecutor = Executor(entity: entity, insertInto: context)
            newExecutor.name = executor.name
            newExecutor.surname = executor.surname
            newExecutor.age = Int16(executor.age)
            newExecutor.country = executor.country
            newExecutor.id = executor.id
        }
        saveContext()
    }
    func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print(error)
            }
        }
    }
}
