//
//  CRUDManager.swift
//  Ledger 0.1.2
//
//  Created by Malik Falana on 6/20/22.
//

import Foundation
import SwiftUI
import CoreData


class CRUDManager: ObservableObject
{
    @Published var activeLibraries: [Lib] = [Lib]()
    @Published var tabs: [String] = []
    //@Published var libraryManager = LibraryManager()
    //@Published var mangaManager = MangaManager()
    
    
    let chapterLimit = 100
    var chapterOffset = 0
    var chapterTotal = 0
    @Published var chapters: [ChapterResponse.Chapter]! = [ChapterResponse.Chapter]()
    @Published var XXX: [Chapter] = [Chapter]()
    @Published var YYY: PageResponse!
   // @Published var ZZZ = [String]()
    @Published var History: [Chapter] = [Chapter]()
    
    
    @Published var isLoading: Bool = false
    @Published var editMode = false
    @Published var isOrient = false //pageview oreintation
    
    @Published var staticLibrary: Lib = Lib()
    
    
    var Response: String = ""
    
    //@Published var pageURL: String! = ""
    //@Published var pageHASH: String! = ""
    //@Published var pageDATA: [String]! = []
    
    
    static let shared = CRUDManager()
    let persistentContainer: NSPersistentContainer
    
    //let ONE: NSEntityDescription
    //let PIECE: NSEntityDescription
    var viewContext: NSManagedObjectContext
    {
        return persistentContainer.viewContext
    }

    init()
    {
        persistentContainer = NSPersistentContainer(name: "Ledger")
        
        
        //ONE = Manga.entity()
        //PIECE = Chapter.entity()
        load()
        Save()
   }
    
    func Create() //Create or Insert
    {
        
    }
    
    func Read() //Reads in all saved libraries // Read or Select
    {
        fetchLibraries()
        
    }
    
    private func Update()
    {
        //UpdateLibrary()
        //SaveLibrary()
    }
    
    private func Delete() //Delete or Remove
    {
        //RemoveLibrary()
        //RemoveManga()
    }
    
    
    
    
    
    
    func load()
    {
        persistentContainer.loadPersistentStores
        {
            (description, error) in
            if let error = error
            {
                print("Error loading Core Data: \(error.localizedDescription)")
            }
            else
            {
                print("Loading successful")
            }
        }
        
        //CacheCheck()
        fetchLibraries()
        fetchHistory()
    }
    
    
    
    func Save()
    {
        do
        {
            if viewContext.hasChanges
            {
                DispatchQueue.main.async
                { [self] in
                    Task
                    {
                        try viewContext.save()
                        print("Changes successfully saved")
                        fetchLibraries()
                    }
                }
            }
            else
            {
                try viewContext.save()
                print("Successfully saved")
            }
        }
        catch
        {
            print("Error occured while saving: \(error.localizedDescription)")
            print("Unsuccessful Save")
        }
        
    }
    
    
    func getAuthor(Source: CollectionResponse.mangaCollection.Relationship?) -> Author
    {
        let newAuthor = Author(context: viewContext)
        newAuthor.id = Source?.id
        newAuthor.name = Source?.attributes?.name ?? ""
        
        return newAuthor
    }
    
    func getArtist(Source: CollectionResponse.mangaCollection.Relationship?) -> Artist
    {
        let newArtist = Artist(context: viewContext)
        newArtist.id = Source?.id
        newArtist.name = Source?.attributes?.name ?? ""
        
        return newArtist
    }
    
    func getTags(Source: CollectionResponse.mangaCollection.Attributes.Tag) -> Tag
    {
        let newTag = Tag(context: viewContext)
        newTag.id = Source.id
        newTag.name = Source.attributes.name.en
        
        return newTag
        
    }
}



// MARK:- Helper Functions

extension CRUDManager
{
//    func addLibrary(name: String, data: [Manga])
//    {
//        let newLibrary = Lib(context: persistentContainer.viewContext)
//
//        newLibrary.id = UUID()
//        newLibrary.name = name
//        newLibrary.data = data
//        print(name)
//        activeLibraries.append(newLibrary)
//        //Save()
//        //Append()
//
//
//    }
    
    func createLibrary(name: String, data: NSOrderedSet)
    {
        let GOLD = NSEntityDescription.entity(forEntityName: "Lib", in: viewContext)!
        let newLibrary = Lib(entity: GOLD, insertInto: viewContext)
        //let newLibrary = Lib(context: viewContext)
        
        newLibrary.id = UUID()
        newLibrary.name = name
        newLibrary.data = data
        print(name)
        activeLibraries.append(newLibrary)
        tabs.append(name)
        //fetchLibraries()
        // Should save here
        Save()
        
        //fetchLibraries()
        //Append() // multiple
        
        //return newLibrary
    }
    
    func updateLibrary(Library: Lib, name: String)
    {
        Library.name = name
        //activeLibraries.append(newLibrary)
        //tabs.append(name)
        //fetchLibraries()
        // Should save here
        Save()
        
        //fetchLibraries()
        //Append() // multiple
        
        //return newLibrary
    }
    
    
    
    func fetchLibraries() //Function that fetaches all saved libraries
    {
        do
        {
            tabs.removeAll()
            activeLibraries = try viewContext.fetch(Lib.fetchRequest())
            //activeLibraries = NSFetchRequest<Lib>(entityName: "Lib")
            //print("Libraries: \(activeLibraries)")
            //print("Libraries: \(activeLibraries[0].data)")
            for i in activeLibraries
            {
                tabs.append(i.name)
            }
            //Save()
        }
        catch
        {
            print("Error fetching Libraries. \(error.localizedDescription)")
        }
    }
    
    func fetchHistory() //Function that fetches all read History
    {
        do
        {
            History.removeAll()
            let x = try viewContext.fetch(Read_History.fetchRequest())
            print(x.first?.data)
            History = x.first?.data ?? []
            //Read_History.fetchRequest().propertiesToFetch?.first.
            //activeLibraries = NSFetchRequest<Lib>(entityName: "Lib")
            //print("Libraries: \(activeLibraries)")
            //print("Libraries: \(activeLibraries[0].data)")
            
            //Save()
        }
        catch
        {
            print("Error fetching Read Data. \(error.localizedDescription)")
        }
    }
    
    func updateHistory(Source: Chapter) // func that updates history
    {
        let newHistory = NSEntityDescription.insertNewObject(forEntityName: "Read_History", into: viewContext) as! Read_History
        newHistory.data?.append(Source)
        Save()
    }
    
    func deleteLibrary(Library: Lib)
    {
        print("Removing \(Library.name)")
        viewContext.delete(Library)
        Save()
        //fetchLibraries()
    }
   
    
    
}

// MARK:- Manga related Functions
extension CRUDManager
{
    /*func createManga(id: String, title: String, author: String, artist: String, cover: String, status: String, synopsis: String) async throws -> Manga
    {
        //await populateChapter(ID: id)
        let newManga = Manga(context: viewContext)
        
        newManga.id = id
        newManga.title = title
        newManga.author = author
        newManga.artist = artist
        newManga.cover = cover
        newManga.status = status
        newManga.synopsis = synopsis
        //newManga.tags = tags
        //newManga.tagCount = tagCount
        
        
       // newManga.chapters = XXX
        
        await fetchChapter(mangaId: id)
        while chapters.count != chapterTotal
        {
            await fetchChapter(mangaId: id)
        }
        for i in chapters.indices
        {
            var E = try! await self.createChapter(id: chapters[i].id, title: chapters[i].attributes.title ?? "", chapterNumber: chapters[i].attributes.chapter ?? "", pages: Int(chapters[i].attributes.pages), publishDate: chapters[i].attributes.publishAt, mangaTitle: title, mangaId: id)
            //XXX.append(E)
            newManga.addToChapters(E)
            
            
        }
        
        //newManga.addToChapters(XXX)
        
        
        do
        {
            try persistentContainer.viewContext.save()
        }
        catch
        {
            print("Failed to save a Manga named \(title): \(error.localizedDescription)")
        }
        
        
        return newManga
    }
    */
    func findManga(id: String, title: String, author: Author, artist: Artist, cover: String, status: String, synopsis: String, tags: [Tag]) -> Manga
    {
        //await populateChapter(ID: id)
        //let newManga = Manga(context: viewContext)
        
        //let ONE = NSEntityDescription.entity(forEntityName: "Manga", in: viewContext)!
        //let newManga = Manga(entity: ONE, insertInto: viewContext)
        
        //let newManga = NSEntityDescription.insertNewObject(forEntityName: "Manga", into: viewContext)
        
        let newManga = NSEntityDescription.insertNewObject(forEntityName: "Manga", into: viewContext) as! Manga?
        
        
        newManga!.id = id
        newManga!.title = title
        newManga!.author = author
        newManga!.artist = artist
        newManga!.cover = cover
        newManga!.status = status
        newManga!.synopsis = synopsis
        
        for i in tags
        {
            newManga!.addToTags(i)
        }

        
        Save()
        
        
        return newManga!
    }
    
    func addManga(Library: Lib, Manga: Manga) async // Function to add a Manga to a specific Library
    {
            //await addChapters(Manga: Manga)
            Library.addToData(Manga)
            //Library.removeFromData(at: 15)
            Save()
        
        
        // Should save here
        //Save() //issue saving a Manga
    }
    
    func removeManga(Library: Lib, selectedManga: Manga) //Function to remove all instances of a Specific Manga from a Specific Library
    {
        withAnimation
        {
            Library.removeFromData(selectedManga)
        }
        //Library.removeFromData(selectedManga)
        //Library.removeFromData(at: 10)
        do
        {
            try viewContext.save()
            fetchLibraries()
            print("\(selectedManga.title) Successfully removed from \(Library.name)")
        }
        catch
        {
            print("Error occured while removing \(selectedManga.title): \(error.localizedDescription)")
        }
        
        //fetchLibraries()
        
    }
    func deleteManga(selectedManga: Manga)
    {
        viewContext.delete(selectedManga)
    }
    
    
    func updateManga(Manga: Manga) async // Function to update a Manga, as in make sure it has the proper number of Chapters // Will be semi-automatic
    {
        // Get count of chapters manga currently has
       
        await CollectionLoader.shared.getManga(Manga_ID: Manga.id)
        if Manga.cover != CollectionLoader.shared.newCover
        {
            Manga.cover = CollectionLoader.shared.newCover
            print("\(Manga.title) Cover Art Updated")
        }
        print(Manga.cover!)
        // Make a request to api to see total number of chapters
        //removeElements(Offset: 0)
        await fetchChapter(Manga: Manga)
        
        let prevChapterCount = Manga.chapters?.count
        let newChapterCount: Int = chapterTotal
        let Total = newChapterCount - prevChapterCount!
        
        // Check If numbers are equal to each other
        if prevChapterCount != newChapterCount
        {
            if Total == 1
            {
                Response = "\(Total) Chapter found!"
            }
            else
            {
                Response = "\(Total) New Chapters found!"
            }
            print(Response)
            
            await addChapters(Manga: Manga, prevTotal: prevChapterCount!, Total: Total)
        }
        else
        {
            Response = "No New Chapters found."
            print(Response)
        }
        
        
        Save()
    }
    
    
    func addChapters(Manga: Manga, prevTotal: Int, Total: Int) async // Function to add chapters while saving
    {
        removeElements(Offset: prevTotal)
        //await fetchChapter(mangaId: Manga.id)
        //chapterOffset = prevTotal
        
        while chapters.count != Total
        {
            await fetchChapter(Manga: Manga)
        }
        for i in chapters.indices
        {
            DispatchQueue.main.async
            { [self] in
                let E = createChapter(id: chapters[i].id, title: chapters[i].attributes.title ?? "", chapterNumber: chapters[i].attributes.chapter ?? "", pages: Int(chapters[i].attributes.pages), publishDate: chapters[i].attributes.publishAt)
                if Manga.chapters?.count != chapterTotal
                {
                    Manga.addToChapters(E)
                }
            }
        }
        
    }
    
    func downloadChapter(Manga: Manga, Chapter: Chapter) async
    {
        //await fetchChapter(Manga: Chapter.source!)
        await CollectionLoader.shared.fetchPage(chapterId: Chapter.id!)
        var i = 0
        var URL = [String]()
        let Count = Int(Chapter.pages)
        
        let Base = CollectionLoader.shared.pages?.baseURL ?? ""
        let Hash = CollectionLoader.shared.pages?.chapter.hash ?? ""
        let Page = CollectionLoader.shared.pages?.chapter.data ?? []
        
        while i != Count
        {
            let link = "\(CollectionLoader.shared.pages?.baseURL ?? "https://uploads.mangadex.org")/data/\(CollectionLoader.shared.pages?.chapter.hash ?? "61e6709e4b6b57a19e45c486be25b842")/\(CollectionLoader.shared.pages?.chapter.data[i] ?? "13-9026c5b869dbe56a3accbec64800e6d02c9b12444d46317041963b829aa80766.jpg")"
            URL.append(link)
            //Chapter.savedPages!.append(link)
            //Manga.addToSaved(Chapter)
            //Save()
            i += 1
            
        }
        print(URL)
        Chapter.savedPages = URL
        Manga.addToSaved(Chapter)
        Save()
        
        //"\(network.pages?.baseURL ?? "")/data/\(network.pages?.chapter.hash ?? "")/\(network.pages?.chapter.data[index] ?? "")"
        
        //print(Chapter.source.)
    }
    
    func refreshProfile(Manga: Manga) async
    {
        Task
        {
            isLoading = true
            Thread.sleep(forTimeInterval: 1.5)
            withAnimation
            {
                Task
                {
                    await updateManga(Manga: Manga)
                }
                isLoading = false
            }
        }
    }
    
}



// MARK:- Chapter related Functions
extension CRUDManager
{
    
    
    func createChapter(id: String, title: String, chapterNumber: String, pages: Int, publishDate: Date) -> Chapter
    {
        //await populatePage(ID: id, pages: 0..<pages)
        //let newChapter = Chapter(context: viewContext)
        //let PIECE = NSEntityDescription.entity(forEntityName: "Chapter", in: viewContext)!
        //let newChapter = Chapter(entity: PIECE, insertInto: viewContext)
        
        let newChapter = NSEntityDescription.insertNewObject(forEntityName: "Chapter", into: viewContext) as! Chapter
        
        newChapter.id = id
        newChapter.title = title
        newChapter.chapterNumber = chapterNumber
        newChapter.pages = Int64(pages)
        newChapter.publishDate = publishDate
        
        //newChapter.nums = []
        //print(ZZZ)
        Save()
        return newChapter
    }
    
    func fetchChapter(Manga: Manga) async
    {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.mangadex.org"
        components.path = "/chapter"
        components.queryItems =
        [
            URLQueryItem(name: "limit", value: "\(chapterLimit)"),
            URLQueryItem(name: "offset", value: "\(chapterOffset)"),
            URLQueryItem(name: "manga", value: Manga.id),
            URLQueryItem(name: "translatedLanguage[]", value: "en")
        ]
        // create url
        guard let url = components.url
        else
        {
            print("Error")
            return
        }
                
        // fetch data from url
        do
        {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            // decode data
            let decodedResponse = try? newJSONDecoder().decode(ChapterResponse.self, from: data)
            if let decodedResponse = decodedResponse
            {
                DispatchQueue.main.async
                { [self] in
                    chapterTotal = decodedResponse.total //Total number of chapters
                    chapterOffset += chapterLimit
                    chapters += decodedResponse.data
                    
                    
                }
            }

        }
        catch let error
        {
            print("ERROR = \(error.localizedDescription)")
        }
    }
    
    func removeElements(Offset: Int) //Function to reset certain variables related to chapters
    {
        if !XXX.isEmpty && !chapters.isEmpty
        {
            XXX.removeAll()
            chapters.removeAll()
        }
        //ZZZ.removeAll()
        //chapterTotal = 0
        chapterOffset = Offset
    }
    
}


