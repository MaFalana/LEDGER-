////
////  dataManager.swift
////  Ledger 0.1.2
////
////  Created by Malik Falana on 6/2/22.
////
//
//import Foundation
//import CoreData
//
//class CoreDataManager: ObservableObject
//{
//    @Published var mangos: [Manga] = [Manga]()
//    let persistentContainer: NSPersistentContainer
//    
//    init()
//    {
//        persistentContainer = NSPersistentContainer(name: "Model")
//        persistentContainer.loadPersistentStores
//        {
//            (description, error) in
//            if let error = error
//            {
//                fatalError("Core Data Store failed: \(error.localizedDescription)")
//            }
//        }
//    }
//    
//    func saveManga(id: String, title: String, author: String, artist: String, cover: String, status: String, synopsis: String)
//    {
//        let manga = Manga(context: persistentContainer.viewContext)
//        manga.id = id
//        manga.title = title
//        manga.author = author
//        manga.artist = artist
//        manga.cover = cover
//        manga.status = status
//        manga.synopsis = synopsis
//        
////        manga.genreTags = [genreTags]
//        //manga.chapterList = [chapterList]
//        
//        do
//        {
//            try persistentContainer.viewContext.save()
//        }
//        catch
//        {
//            print("Failed to save Manga \(error.localizedDescription)")
//        }
//    }
//    
//    func deleteManga(selectedManga: Manga)
//    {
//        persistentContainer.viewContext.delete(selectedManga)
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
