////
////  LibraryManager.swift
////  Ledger 0.1.2
////
////  Created by Malik Falana on 6/17/22.
////
//
//import Foundation
//import CoreData
//
//class LibraryManager: ObservableObject
//{
//    //@Published var activeLibraries = [Lib]()
//    //@Published var tabs = [String]()
//    @Published var crudManager = CRUDManager()
//
//
//    let persistentContainer: NSPersistentContainer
//
//    init()
//    {
//        persistentContainer = NSPersistentContainer(name: "Manga")
//        persistentContainer.loadPersistentStores
//        {
//            (description, error) in
//            if let error = error
//            {
//                fatalError("Core Data Store failed: \(error.localizedDescription)")
//            }
//        }
//
//   }
//
//    func addLibrary(name: String, data: [Manga])
//    {
//        let newLibrary = Lib(context: persistentContainer.viewContext)
//
//        newLibrary.id = UUID()
//        newLibrary.name = name
//        newLibrary.data = data
//        print(name)
//        crudManager.activeLibraries.append(newLibrary)
//        crudManager.tabs.append(newLibrary.name!)
//        saveLibrary()
//
//    }
//
//    func deleteManga(selectedLibrary: Lib)
//    {
//        persistentContainer.viewContext.delete(selectedLibrary)
//
//        do
//        {
//           try persistentContainer.viewContext.save()
//        }
//        catch
//        {
//            persistentContainer.viewContext.rollback()
//            print("Failed to save context \(error.localizedDescription)")
//        }
//    }
//
//    func populateTabNames()
//    {
//        for i in crudManager.activeLibraries
//        {
//            crudManager.tabs.append(i.name!)
//        }
//        print(crudManager.tabs)
//        //return tabs
//    }
//
//
//    func addToLibrary()
//    {
//        //activeLibraries[0].data.append(Manga)
//    }
//
//    func saveLibrary()
//    {
//        do
//        {
//            try persistentContainer.viewContext.save()
//            crudManager.fetchLibraries()
//        }
//        catch let error
//        {
//            print("Error saving library. \(error)")
//        }
//    }
//}
