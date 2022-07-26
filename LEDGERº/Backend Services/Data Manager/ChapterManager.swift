//
//  ChapterManager.swift
//  Ledger 0.1.2
//
//  Created by Malik Falana on 6/19/22.
//

import Foundation
import SwiftUI
import CoreData

class ChapterManager: ObservableObject
{
    //@Environment(\.managedObjectContext) private var viewContext
    //@State private var userInput = ""
    //@Published var savedMangas: [Manga] = [Manga]()
    let persistentContainer: NSPersistentContainer
    let chapterLimit = 100
    var chapterOffset = 0
    var chapterTotal = 0
    private var chapters: [ChapterResponse.Chapter]! = [ChapterResponse.Chapter]()
    
    init()
    {
        persistentContainer = NSPersistentContainer(name: "Manga")
        persistentContainer.loadPersistentStores
        {
            (description, error) in
            if let error = error
            {
                fatalError("Core Data Store failed: \(error.localizedDescription)")
            }
        }
    }
    
    func createChapter(id: String, title: String, chapterNumber: String, pages: Int64, publishDate: Date) -> Chapter
    {
        //chapters = []
        //await populateChapter(ID: id)
        let newChapter = Chapter(context: persistentContainer.viewContext)
        
        newChapter.id = id
        newChapter.title = title
        newChapter.chapterNumber = chapterNumber
        newChapter.pages = pages
        newChapter.publishDate = publishDate
        

        for i in chapters.indices
        {
            newChapter.id = chapters[i].id
            newChapter.title = chapters[i].attributes.title
            newChapter.chapterNumber = chapters[i].attributes.chapter
            newChapter.pages = Int64(chapters[i].attributes.pages)
            newChapter.publishDate = chapters[i].attributes.publishAt
        }
        
        
        
        do
        {
            try persistentContainer.viewContext.save()
        }
        catch
        {
            print("Failed to save a Chapter \(error.localizedDescription)")
        }
        return newChapter
    }
    
    func populateChapter(ID: String) async
    {
        chapters.removeAll()
        await fetchChapter(mangaId: ID)
        while chapters.count != chapterTotal
        {
            await fetchChapter(mangaId: ID)
        }
        print(ID)
        print("Number of chpaters: \(chapters.count) / \(chapterTotal)")
    }
    
    func fetchChapter(mangaId: String) async
    {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.mangadex.org"
        components.path = "/chapter"
        components.queryItems =
        [
            URLQueryItem(name: "limit", value: "\(chapterLimit)"),
            URLQueryItem(name: "offset", value: "\(chapterOffset)"),
            URLQueryItem(name: "manga", value: mangaId),
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
                {
                    self.chapterTotal = decodedResponse.total //Total number of chapters
                    self.chapterOffset += self.chapterLimit
                    self.chapters += decodedResponse.data
                    
//                    newChapter.id = decodedResponse.data[i].id
//                    newChapter.title = decodedResponse.data[i].attributes.title
//                    newChapter.number = decodedResponse.data[i].attributes.chapter
//                    newChapter.pages = decodedResponse.data[i].attributes.pages
                   
                    /*self.chapterCount = decodedResponse.data[Index].count //Number of Chapters
                    self.chapterId = decodedResponse.data[Int].id// Specific Chapter Id
                    self.chapterTitle = decodedResponse.data[Int].attributes.title //Chapter Title
                    self.chapterNumber = decodedResponse.data[Int].attributes.chapter //Chapter Number
                    self.chapters = decodedResponse.data[index].attributes.pages // Number of pages*/
                    //decodedResponse.data[3].attributes.pages
                    
                    
                }
                
            }
//            print("There are \(decodedResponse?.data.count) chapters")
//            print("Most Recent Chapter: \(decodedResponse?.data.last?.attributes.title)") //Chapter Title
//            print("Most Recent Chapter #: \(decodedResponse?.data.last?.attributes.chapter)")
//            print("Total is \(decodedResponse?.total)")
//            print(decodedResponse?.data)
        }
        catch let error
        {
            print("ERROR = \(error.localizedDescription)")
        }
    }
}
