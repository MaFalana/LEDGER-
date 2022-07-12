//
//  libraryDataManager.swift
//  Ledger 0.1.2
//
//  Created by Malik Falana on 6/11/22.
//

import Foundation
import CoreData

class LibraryDataManager: ObservableObject
{
    @Published var activeLibraries = [libraryModel]()
    @Published var tabs = [String]()
    
    let persistentContainer: NSPersistentContainer

    init()
    {
        persistentContainer = NSPersistentContainer(name: "Model")
        persistentContainer.loadPersistentStores
        {
            (description, error) in
            if let error = error
            {
                fatalError("Core Data Store failed: \(error.localizedDescription)")
            }
        }
   }
    
    func populateTabNames() throws -> [String]
    {
        for i in activeLibraries
        {
            tabs.append(i.name)
        }
        print(tabs)
        return tabs
    }
    
    func createNewLibrary(userInput: String)
    {
        //activeLibraries.append( userLibrary(name: <#T##String#>, data: <#T##[CollectionResponse.mangaCollection]#>) ) //userInput is library name
    }
    
    func saveLibrary(name: String, dat: [CollectionResponse.mangaCollection] )
    {
        //let library = Lib(context: persistentContainer.viewContext)

        //library.id = id
        //library.name = name
        //library.data = data

        do
        {
            try persistentContainer.viewContext.save()
        }
        catch
        {
            print("Failed to save Library \(error.localizedDescription)")
        }
    }
    
    func deleteLibrary(selectedLibrary: LibraryEntity)
    {
        persistentContainer.viewContext.delete(selectedLibrary)

        do
        {
          try persistentContainer.viewContext.save()
        }
        catch
        {
            persistentContainer.viewContext.rollback()
            print("Failed to save context \(error.localizedDescription)")
       }
   }
}


    

//    func getLibrary() -> [Manga]
//    {
//        let fetchRequest: NSFetchRequest<Manga> = Manga.fetchRequest()
//
//        do
//        {
//           return try persistentContainer.viewContext.fetch(fetchRequest)
//        }
//        catch
//        {
//            return []
//        }
//    }
//
//    func populateArray()
//    {
//        mangos = getLibrary()
//    }
//
//}




