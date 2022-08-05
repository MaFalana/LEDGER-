//
//  CRUDManager.swift
//  Ledger 0.1.2
//
//  Created by Malik Falana on 6/20/22.
//

import Foundation
import SwiftUI
import CoreData
import CloudKit


class CRUDManager: ObservableObject
{
    @Published var activeLibraries: [Lib] = []
    @Published var tabs: [String] = []
    //@Published var libraryManager = LibraryManager()
    //@Published var mangaManager = MangaManager()
    
    var WON = 0
    var chapterLimit = 100
    var chapterOffset = 0
    var chapterTotal = 0
    @Published var chapters: [ChapterResponse.Chapter]! = [ChapterResponse.Chapter]()
    @Published var XXX: [Chapter] = [Chapter]()
    @Published var YYY: PageResponse!
   // @Published var ZZZ = [String]()
    @Published var Hist: [History] = []
    @Published var Back: [Backup] = []
    
    @State private var showAlert = false
    @Published var isLoading: Bool = false
    @Published var editMode = false
    @Published var isOrient = false //pageview oreintation
    @Published var isReading = false
    @Published var isHidden = true
    @Published var isSyncing = false
    @Published var chapterOrder = 0
    @Published var staticLibrary: Lib = Lib()
    @Published var rowItems = 3
    @Published var selectedChapter: Chapter = Chapter()
    
    var Response: String = ""
    var newCover: String  = ""
    
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
        fetchBackup()
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
    func changeChapter(X: Chapter)
    {
        selectedChapter = X
        Task
        {
            await CollectionLoader.shared.fetchPage(chapterId: X.id!)
        }
    }
    
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
        //load()
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
    
    func deleteLibrary(Library: Lib)
    {
        
//        .onDelete { indexSet in
//            CRUDManager.shared.activeLibraries.remove(atOffsets: indexSet)
//        }
//
        activeLibraries.remove(at: activeLibraries.firstIndex(of: Library)!)
        print("Removing \(Library.name)")
        viewContext.delete(Library)
        objectWillChange.send()
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
            await updateManga(Manga: Manga)
            Library.addToData(Manga)
            //Library.removeFromData(at: 15)
            Save()
        
        
        // Should save here
        //Save() //issue saving a Manga
    }
    
    func removeManga(Library: Lib, selectedManga: Manga) //Function to remove all instances of a Specific Manga from a Specific Library
    {
        
        //Library.removeFromData(selectedManga)
        //Library.removeFromData(at: 10)
        do
        {
            withAnimation
            {
                Library.removeFromData(selectedManga)
                viewContext.delete(selectedManga)
            }
            try viewContext.save()
            objectWillChange.send()
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
        newCover = CollectionLoader.shared.newCover
        
        if newCover != "" && newCover.contains(Manga.id) && Manga.cover != newCover
        {
            print("Previous Cover: \(Manga.cover!)")
            Manga.cover = newCover
            print("Current Cover: \(newCover)")
            print("\(Manga.title) Cover Art Updated")
        }
        
        // Make a request to api to see total number of chapters
        //removeElements(Offset: 0)
        
        
        await fetchChapter(Manga: Manga)
        
        let prevChapterCount = Manga.chapters!.count
        let newChapterCount = chapterTotal
        let Total = newChapterCount - prevChapterCount
        
        // Check If numbers are equal to each other
        if prevChapterCount != newChapterCount
        {
            if Total == 1
            {
                Response = "\(Total) Chapter Found!"
            }
            else
            {
                Response = "\(Total) New Chapters Found!"
            }
            print(Response)
            
            await addChapters(Manga: Manga, prevTotal: prevChapterCount, Total: Total)
        }
        else
        {
            Response = "No New Chapters found."
            print(Response)
        }
        
        chapters.removeAll()
        XXX.removeAll()
        chapterLimit = 100
        Save()
    }
    
    
    func addChapters(Manga: Manga, prevTotal: Int, Total: Int) async // Function to add chapters while saving
    {
        chapters.removeAll()
        chapterOffset = prevTotal
        let V: [Chapter] = Array(_immutableCocoaArray: Manga.chapters ?? [])
        while chapters.count != Total
        {
            print("Chapter Count: \(chapters.count)\t Total: \(Total)")
            let Remainder = Total - chapters.count
            if Remainder <= 100
            {
                chapterLimit = Remainder
            }
            await fetchChapter(Manga: Manga)
        }
        //chapters.sort{Float($0.attributes.chapter!)! < Float($1.attributes.chapter!)!}
        for i in chapters.indices
        {
            let id = chapters[i].id
            let title = chapters[i].attributes.title ?? ""
            let Number = chapters[i].attributes.chapter ?? ""
            let Pages = Int(chapters[i].attributes.pages)
            let ReadDate = chapters[i].attributes.readableAt
            let externalURL = chapters[i].attributes.externalURL ?? ""
            
            let E = createChapter(id: id, title: title, chapterNumber: Number, pages: Pages, publishDate: ReadDate, externalURL: externalURL)
            if Manga.chapters?.count != chapterTotal
            {
                if V.contains(where: { $0.id == E.id})
                {
                    print("Chapter is already saved")
                }
                else
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
        
        while i != Count
        {
            let link = "\(CollectionLoader.shared.pages?.baseURL ?? "https://uploads.mangadex.org")/data/\(CollectionLoader.shared.pages?.chapter.hash ?? "")/\(CollectionLoader.shared.pages?.chapter.data[i] ?? "")"
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
    func sortChapters<Chapter: Comparable>(_ a: [Chapter]) -> [Chapter] //Method to QuickSort chapters in a MangaDex Manga
    {
        guard a.count > 1 else
        {
            return a //already sorted if less than or equal to one
        }
        
        let pivot = a[a.count / 2]
        let less = a.filter { $0 < pivot }
        let equal = a.filter { $0 == pivot }
        let greater = a.filter { $0 > pivot }
        
        return sortChapters(less) + equal + sortChapters(greater)
    }
    
    func createChapter(id: String, title: String, chapterNumber: String, pages: Int, publishDate: Date, externalURL: String) -> Chapter
    {
        //await populatePage(ID: id, pages: 0..<pages)
        let newChapter = Chapter(context: viewContext)
        //let PIECE = NSEntityDescription.entity(forEntityName: "Chapter", in: viewContext)!
        //let newChapter = Chapter(entity: PIECE, insertInto: viewContext)
        
        //let newChapter = NSEntityDescription.insertNewObject(forEntityName: "Chapter", into: viewContext) as! Chapter
        
        newChapter.id = id
        newChapter.title = title
        newChapter.chapterNumber = chapterNumber
        newChapter.pages = Int64(pages)
        newChapter.publishDate = publishDate
        newChapter.externalURL = externalURL
        
        //newChapter.nums = []
        //print(ZZZ)
        Save()
        return newChapter
    }
    
    func fetchChapter(Manga: Manga) async
    {
        print("function called")
        print(WON)
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.mangadex.org"
        components.path = "/chapter"
        components.queryItems =
        [
            URLQueryItem(name: "limit", value: "\(chapterLimit)"),
            URLQueryItem(name: "offset", value: "\(chapterOffset)"),
            URLQueryItem(name: "manga", value: Manga.id),
            URLQueryItem(name: "translatedLanguage[]", value: "en"),
            URLQueryItem(name: "contentRating[]", value: "safe"),
            URLQueryItem(name: "contentRating[]", value: "suggestive"),
            URLQueryItem(name: "contentRating[]", value: "erotica"),
            URLQueryItem(name: "contentRating[]", value: "pornographic")
        ]
        // create url
        guard let url = components.url
        else
        {
            print("Error")
            return
        }
         print("Url created")
        // fetch data from url
        do
        {
            let (data, _) = try await URLSession.shared.data(from: url)
            print("Data assigned")
            // decode data
            let decodedResponse = try? newJSONDecoder().decode(ChapterResponse.self, from: data)
            print("Data decoded")
            if let decodedResponse = decodedResponse
            {
                chapterTotal = decodedResponse.total //Total number of chapters
                chapterOffset += chapterLimit
                chapters += decodedResponse.data
                print(decodedResponse.data.first)

            }
            print("Data saved to chapters")

        }
        catch
        {
            print("ERROR = \(error.localizedDescription)")
        }
        WON += 1
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


extension CRUDManager //Backup
{
    func fetchBackup()
    {
        do
        {
            Back.removeAll()
            Back = try viewContext.fetch(Backup.fetchRequest())
            print("Backup 1: \(Back.first?.libraries?.firstObject)")
            //Save()
        }
        catch
        {
            print("Error fetching Backups. \(error.localizedDescription)")
        }
    }
    
    func createBackup()
    {
        do
        {
            let newBackup = Backup(context: viewContext)
            
            let A: [History] = try viewContext.fetch(History.fetchRequest())
            let B: [Lib] = try viewContext.fetch(Lib.fetchRequest())
            //let C: [Backup] = try viewContext.fetch(Backup.fetchRequest())
            
        
            newBackup.id = UUID()
            newBackup.creationDate = Date()
            for i in A
            {
                newBackup.addToHistory(i)
            }
            for i in B
            {
                newBackup.addToLibraries(i)
            }
            print(newBackup)
            Back.append(newBackup)
            Save()
        }
        catch
        {
            print("Error creating Backup. \(error.localizedDescription)")
        }
        
    }
    
    func deleteBackup(selectedBackup: Backup)
    {
        Back.removeAll(where: {$0 == selectedBackup})
        viewContext.delete(selectedBackup)
        Save()
    }
    
    func loadBackup(selectedBackup: Backup)
    {
        activeLibraries.removeAll()
        tabs.removeAll()
        var newLibraries: [Lib]
        {
            return Array(_immutableCocoaArray: selectedBackup.libraries ?? [] )
        }
        var newHistory: [History]
        {
            return Array(_immutableCocoaArray: selectedBackup.history ?? [] )
        }
        activeLibraries = newLibraries
        for i in activeLibraries
        {
            tabs.append(i.name)
        }
        Hist = newHistory
//        selectedTheme = selectedBackup.theme
        //print(selectedBackup.libraries?.firstObject as! Lib)
        print("Libraries: \(newLibraries)")
        print("History: \(newHistory)")
        print(activeLibraries)
//        Save()
//        load()
//        Save()
    }
}


extension CRUDManager //History
{
    
    
    func createHistory(Chapter: Chapter)
    {
        let ID = Chapter.id
        
        //newHistory.source = Chapter.source
        if Hist.contains(where: {$0.chapter?.id! == ID})
        {
            for i in Hist
            {
                if i.chapter?.id! == ID
                {
                    i.readDate = Date()
                }
            }
        }
        else
        {
            let newHistory = History(context: viewContext)
            newHistory.readDate = Date()
            newHistory.chapter = Chapter
            Hist.append(newHistory)
        }
        Save()
    }
    
    func fetchHistory() //Read function
    {
        do
        {
            Hist.removeAll()
            Hist = try viewContext.fetch(History.fetchRequest())
            //Save()
        }
        catch
        {
            print("Error readind in History. \(error.localizedDescription)")
        }
    }
    
    func updateHistory(X: History)
    {
        X.readDate = Date()
    }
    
    func deleteHistory()
    {
        do
        {
            let Objects: [History] = try viewContext.fetch(History.fetchRequest())
//            Hist.removeAll()
//            Hist = try viewContext.fetch(History.fetchRequest())
            for i in Objects // Delete multiple objects
            {
                viewContext.delete(i)
            }
            Hist.removeAll()
            try viewContext.save() // Save the deletions to the persistent store
        }
        catch
        {
            print("Error deleting History. \(error.localizedDescription)")
        }
    }
    
    func Reset()
    {
        do
        {
            let A: [History] = try viewContext.fetch(History.fetchRequest())
            let B: [Lib] = try viewContext.fetch(Lib.fetchRequest())
            let C: [Backup] = try viewContext.fetch(Backup.fetchRequest())
            
            for i in A // Deletes multiple objects
            {
                viewContext.delete(i)
            }
            for i in B // Delete multiple objects
            {
                viewContext.delete(i)
            }
            for i in C // Delete multiple objects
            {
                viewContext.delete(i)
            }
            tabs.removeAll()
            Hist.removeAll()
            Back.removeAll()
            activeLibraries.removeAll()
            try viewContext.save() // Save the deletions to the persistent store
        }
        catch
        {
            print("Error resetting App. \(error.localizedDescription)")
        }
    }
}
