

import Foundation
import CoreData

final class PresistentManager{
    private init(){
        
    }
    
     static let shared = PresistentManager()
    
    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "RemindMe")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    lazy var context = persistentContainer.viewContext
    
    
    // MARK: - Core Data Saving support
    
    func save() -> Bool {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
                print("#### Saved succesfully")
                return true
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
        return false
    }
    
    func fetch<T: NSManagedObject>( _ objectType : T.Type) -> [T]{
        // getting entityname
        let entityName = String(describing: objectType)
        
        let fetchrequet = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        
        do{
            guard let fetchObject = try! context.fetch(fetchrequet) as? [T] else { return [T]() }
            return fetchObject
        }catch{
            print(error)
            return [T]()
        }
    }
    
    func delete(_ object : NSManagedObject){
        context.delete(object)
        save()
    }
    
    func deleteAllData<T : NSManagedObject>( _ objectType : T.Type){
        let entityname = String(describing: objectType)
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityname)
        let request = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        do{
            try context.execute(request)
            save()
            print("#### Deleted successfully")
        }catch{
            print("@@@@Error",error)
        }
    }
}
