////
////  MangaManager.swift
////  Ledger 0.1.2
////
////  Created by Malik Falana on 6/17/22.
////
//
//import Foundation
//import SwiftUI
//import CoreData
//
//class MangaManager: ObservableObject
//{
//    //@Environment(\.managedObjectContext) private var viewContext
//    //@State private var userInput = ""
//    //@Published var savedMangas: [Manga] = [Manga]()
//    let persistentContainer: NSPersistentContainer
//    let chapterLimit = 100
//    var chapterOffset = 0
//    var chapterTotal = 0
//    @Published var chapters: [ChapterResponse.Chapter]! = [ChapterResponse.Chapter]()
//    @Published var XXX: [Chapter] = [Chapter]()
//    @Published var YYY: PageResponse!
//    @Published var ZZZ = [String]()
//    @Published var pageURL: String! = ""
//    @Published var pageHASH: String! = ""
//    @Published var pageDATA: [String]! = []
//
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
//    }
//
//    func saveManga(id: String, title: String, author: String, artist: String, cover: String, status: String, synopsis: String)
//    {
//        let newManga = Manga(context: persistentContainer.viewContext)
//        newManga.id = id
//        newManga.title = title
//        newManga.author = author
//        newManga.artist = artist
//        newManga.cover = cover
//        newManga.status = status
//        newManga.synopsis = synopsis
//        //newManga.tags = tags
//        //newManga.tagCount = tagCount
//        //newManga.tag = tag
//
//        //newManga.chapterCount = Int32(chapterCount)
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
//    func createManga(id: String, title: String, author: String, artist: String, cover: String, status: String, synopsis: String) async throws -> Manga
//    {
//        await populateChapter(ID: id)
//        let newManga = Manga(context: persistentContainer.viewContext)
//
//        newManga.id = id
//        newManga.title = title
//        newManga.author = author
//        newManga.artist = artist
//        newManga.cover = cover
//        newManga.status = status
//        newManga.synopsis = synopsis
//        //newManga.tags = tags
//        //newManga.tagCount = tagCount
//
//
//        newManga.chapters = XXX
//
//
//        do
//        {
//            try persistentContainer.viewContext.save()
//        }
//        catch
//        {
//            print("Failed to save this Manga \(error.localizedDescription)")
//        }
//
//        //chapters.removeAll()
//        //XXX.removeAll()
//        return newManga
//    }
//
//    func createChapter(id: String, title: String, chapterNumber: String, pages: Int, publishDate: Date) async throws -> Chapter
//    {
//        //await populatePage(ID: id, pages: 0..<pages)
//        let newChapter = Chapter(context: persistentContainer.viewContext)
//
//        newChapter.id = id
//        newChapter.title = title
//        newChapter.chapterNumber = chapterNumber
//        newChapter.pages = Int64(pages)
//        newChapter.publishDate = publishDate
//        //newChapter.nums = []
//        //print(ZZZ)
//
//        do
//        {
//            try persistentContainer.viewContext.save()
//        }
//        catch
//        {
//            print("Failed to save Manga \(error.localizedDescription)")
//        }
//        return newChapter
//    }
//
//    func populateChapter(ID: String) async
//    {
//        removeElements()
//        await fetchChapter(mangaId: ID)
//        while chapters.count != chapterTotal
//        {
//            await fetchChapter(mangaId: ID)
//        }
//        for i in chapters.indices
//        {
//            let E = try! await self.createChapter(id: chapters[i].id, title: chapters[i].attributes.title ?? "", chapterNumber: chapters[i].attributes.chapter ?? "", pages: Int(chapters[i].attributes.pages), publishDate: chapters[i].attributes.publishAt)
//            XXX.append(E)
//
//        }
//        //print("XXX: \(XXX[0].title)")
//        print(ID)
//        print("Number of chpaters: \(chapters.count) / \(chapterTotal)")
//        //chapters.removeAll()
//    }
//
//    func fetchChapter(mangaId: String) async
//    {
//        var components = URLComponents()
//        components.scheme = "https"
//        components.host = "api.mangadex.org"
//        components.path = "/chapter"
//        components.queryItems =
//        [
//            URLQueryItem(name: "limit", value: "\(chapterLimit)"),
//            URLQueryItem(name: "offset", value: "\(chapterOffset)"),
//            URLQueryItem(name: "manga", value: mangaId),
//            URLQueryItem(name: "translatedLanguage[]", value: "en")
//        ]
//        // create url
//        guard let url = components.url
//        else
//        {
//            print("Error")
//            return
//        }
//
//        // fetch data from url
//        do
//        {
//            let (data, _) = try await URLSession.shared.data(from: url)
//
//            // decode data
//            let decodedResponse = try? newJSONDecoder().decode(ChapterResponse.self, from: data)
//            if let decodedResponse = decodedResponse
//            {
//                DispatchQueue.main.async
//                {
//                    self.chapterTotal = decodedResponse.total //Total number of chapters
//                    self.chapterOffset += self.chapterLimit
//                    self.chapters += decodedResponse.data
//                }
//
//            }
//
//        }
//        catch let error
//        {
//            print("ERROR = \(error.localizedDescription)")
//        }
//    }
//
//    func removeElements()
//    {
//        XXX.removeAll()
//        chapters.removeAll()
//        //ZZZ.removeAll()
//        //chapterTotal = 0
//        chapterOffset = 0
//    }
//
//    func fetchPage(chapterId: String) async
//    {
//        // create url
//        guard let url = URL(string: "https://api.mangadex.org/at-home/server/\(chapterId)?forcePort443=false") //link to specific chapter
//        else
//        {
//            print("Error")
//            return
//        }
//
//        // fetch data from url
//        do
//        {
//            let (data, _) = try await URLSession.shared.data(from: url)
//
//            // decode data
//            let decodedResponse = try? newJSONDecoder().decode(PageResponse.self, from: data)
//            if let decodedResponse = decodedResponse
//            {
//                DispatchQueue.main.async
//                {
//                    self.YYY = decodedResponse//This works!!!!
//
//                    self.pageURL = decodedResponse.baseURL
//                    self.pageHASH = decodedResponse.chapter.hash
//                    self.pageDATA = decodedResponse.chapter.data
//                    //print("\(decodedResponse.baseURL)/data/\(decodedResponse.chapter.hash)/\(decodedResponse.chapter.data[0])")
//                    //print("\(self.pageURL!)/data/\(self.pageHASH!)/\(self.pageDATA!.indices)")
//                    //print("\(decodedResponse.baseURL ?? "")/data/\(decodedResponse.chapter.hash ?? "")/\(decodedResponse.chapter.data[0] ?? "")")
//                }
//
//            }
//            //print("\(decodedResponse!.baseURL)/data/\(decodedResponse!.chapter.hash)/\(decodedResponse!.chapter.data[0])")
//            //print("\(pageURL)/data/\(pageHASH)/\(pageDATA)")
//            //{ chapter .chapter.{ quality mode }.[*] }
//
//        }
//        catch let error
//        {
//            print("ERROR = \(error.localizedDescription)")
//        }
//    }
//
//    func populatePage(ID: String, pages: Range<Int>) async
//    {
//        await fetchPage(chapterId: ID)
//        for i in pages
//        {
//            //let E =  "\(self.pageURL!)/data/\(self.pageHASH!)/\(self.pageDATA![i])"
//            let E = "\(YYY?.baseURL ?? "")/data/\(YYY?.chapter.hash ?? "")/\(YYY?.chapter.data[i] ?? "")"
//            ZZZ.append(E)
//        }
//        //print("XXX: \(XXX[0].title)")
//        print("ZZZ: \(ZZZ)")
//        print(ID)
//        print("Number of chpaters: \(chapters.count) / \(chapterTotal)")
//        //chapters.removeAll()
//    }
//
//    func fetchLibraries()
//    {
//        let request = NSFetchRequest<Lib>(entityName: "Lib")
//
//        do
//        {
//            try persistentContainer.viewContext.fetch(request)
//        }
//        catch let error
//        {
//            print("Error fetching. \(error)")
//        }
//    }
//
//}
