//
//  CollectionResponse.swift
//  Ledger.0.0.2
//
//  Created by Malik Falana on 5/29/22.
//

import Foundation
import CoreData
import SwiftUI
//import SwiftUI


class CollectionLoader: ObservableObject
{
    //private let cache = InMemoryCache<[CollectionResponse.mangaCollection]>(expirationInterval: 5 * 60)
    
    //@EnvironmentObject private var  crudManager: CRUDManager =
    
    let Link: String = "https://api.mangadex.org/manga?limit=10&offset=0&includedTagsMode=AND&excludedTagsMode=OR&contentRating%5B%5D=safe&contentRating%5B%5D=suggestive&contentRating%5B%5D=erotica&order%5BlatestUploadedChapter%5D=desc&includes%5B%5D=author&includes%5B%5D=artist&includes%5B%5D=cover_art"
    @Published var searchResults: [Manga]! = [Manga]()

    @Published var collectionData: [Manga]! = [Manga]()
    
    @Published var shounenData: [Manga]! = [Manga]()
    @Published var shoujoData: [Manga]! = [Manga]()
    @Published var joseiData: [Manga]! = [Manga]()
    @Published var seinenData: [Manga]! = [Manga]()
    
    @Published var specificData: [Manga]! = [Manga]()
    
    @Published var Temp: [Manga]! = [Manga]()
    
    @Published var collectionLibrary: [MangaResponse.Manga]? //[CollectionResponse.mangaCollection]?
    //@Published var userLibrary: [MangaResponse.Manga]? = [] // [CollectionResponse.mangaCollection]! = [CollectionResponse.mangaCollection]()
    @Published var MANGA: MangaResponse.Manga! // [MangaResponse.Manga]! = [MangaResponse.Manga]()
    
    @Published var NC: [Chapter]! = []
    
    @Published var chapters: [ChapterResponse.Chapter]! = [ChapterResponse.Chapter]()
    @Published var pageURL: String! = ""
    @Published var pageHASH: String! = ""
    @Published var pageDATA: [String]! = []
    @Published var pages: PageResponse!
    
    @Published var newCover: String = ""
    
    let chapterLimit = 100
    var chapterOffset = 0
    var chapterTotal = 0
    
    var LIMIT = 100
    
    var OFFSET = 0
    var TOTAL = 0
    
    var OFF = 0
    var shounenOFFSET = 0
    var shoujoOFFSET = 0
    var joseiOFFSET = 0
    var seinenOFFSET = 0
    
    var tagOFFSET = 0
    
    static let shared = CollectionLoader()
    
    func loadCollection() async //Function to load Collection
    {
        //browseNum = 20
        //let category = fetchTaskToken.category
//        if let cacheInfo = await cache.value(forKey: collectionData[0].id)
//        {
//            
//        }
        
        await loadMore(Genre: "", Phrase: "none")
        print("Normal: \(self.collectionData!)")
        
        await loadMore(Genre: "shounen", Phrase: "shounen")
        print("Shounen: \(self.shounenData!)")
        
        await loadMore(Genre: "shoujo", Phrase: "shoujo")
        print("Shoujo: \(self.shoujoData!)")

        await loadMore(Genre: "josei", Phrase: "josei")
        print("Josei: \(self.joseiData!)")

        await loadMore(Genre: "seinen", Phrase: "seinen")
        print("Seinen: \(self.seinenData!)")
    }
    
    func loadAll(Genre: String) async //Function to load Collection
    {
       
        if Genre == ""
        {
            OFF += 100
            OFFSET = OFF
            await loadMore(Genre: "", Phrase: "none")
        }
        
        else if Genre == "Shounen"
        {
            shounenOFFSET += 100
            OFFSET = shounenOFFSET
            await loadMore(Genre: "shounen", Phrase: "shounen")
        }
        
        else if Genre == "Shoujo"
        {
            shoujoOFFSET += 100
            OFFSET = shoujoOFFSET
            await loadMore(Genre: "shoujo", Phrase: "shoujo")
        }
        
        else if Genre == "Josei"
        {
            joseiOFFSET += 100
            OFFSET = joseiOFFSET
            await loadMore(Genre: "josei", Phrase: "josei")
        }
        
        else if Genre == "Seinen"
        {
            seinenOFFSET += 100
            OFFSET = seinenOFFSET
            await loadMore(Genre: "seinen", Phrase: "seinen")
        }
    }
    
    func loadMore(Genre: String, Phrase: String) async //Function to load Collection
    {
       //guard let url = URL(string: "https://api.mangadex.org/manga?limit=\(browseNum)&offset=\(OFFSET)&includedTagsMode=AND&excludedTagsMode=OR&availableTranslatedLanguage%5B%5D=en\(Phrase)&contentRating%5B%5D=safe&contentRating%5B%5D=suggestive&contentRating%5B%5D=erotica&order%5BlatestUploadedChapter%5D=desc&includes%5B%5D=author&includes%5B%5D=artist&includes%5B%5D=cover_art")
        
                
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.mangadex.org"
        components.path = "/manga"
        components.queryItems =
        [
            URLQueryItem(name: "limit", value: "\(LIMIT)"),
            URLQueryItem(name: "offset", value: "\(OFFSET)"),
            //URLQueryItem(name: "title", value: "Jujutsu Kaisen"),
            //URLQueryItem(name: "includedTagsMode", value: "AND"),
            //URLQueryItem(name: "excludedTagsMode", value: "OR"),
            //URLQueryItem(name: "contentRating[]", value: "pornographic"),
            URLQueryItem(name: "availableTranslatedLanguage[]", value: "en"),
            URLQueryItem(name: "publicationDemographic[]", value: Phrase),
            URLQueryItem(name: "order[latestUploadedChapter]", value: "desc"),
            URLQueryItem(name: "includes[]", value: "author"),
            URLQueryItem(name: "includes[]", value: "artist"),
            URLQueryItem(name: "includes[]", value: "cover_art")
        ]
        // create url
        guard let url = components.url
                
        else
        {
            print("Error")
            return
        }
        print(url)
        // fetch data from url
        do
        {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            // decode data
            let decodedResponse = try? newJSONDecoder().decode(CollectionResponse.self, from: data)
            TOTAL = decodedResponse!.total
            if let decodedResponse = decodedResponse
            {
                DispatchQueue.main.async
                { [self] in
                    if Genre == ""
                    {
                        //print("Before: \(decodedResponse.data)")
                        Task
                        {
                            Trans(Data: decodedResponse.data, Storage: collectionData, Max: decodedResponse.data.count)
                            collectionData.append(contentsOf: Temp)
                            Temp.removeAll()
                        }
                    }
                    else if Genre == "shounen"
                    {
                        //self.shounenData = decodedResponse.data //This works!!!!
                        Task
                        {
                            Trans(Data: decodedResponse.data, Storage: shounenData, Max: decodedResponse.data.count)
                            shounenData.append(contentsOf: Temp)
                            //print(shounenData[0].title)
                            Temp.removeAll()
                        }
                    }
                    else if Genre == "shoujo"
                    {
                        //shoujoData = decodedResponse.data //This works!!!!
                        Task
                        {
                            Trans(Data: decodedResponse.data, Storage: shoujoData, Max: decodedResponse.data.count)
                            shoujoData.append(contentsOf: Temp)
                            Temp.removeAll()
                        }
                    }
                    else if Genre == "josei"
                    {
                        //joseiData = decodedResponse.data //This works!!!!
                        Task
                        {
                            Trans(Data: decodedResponse.data, Storage: joseiData, Max: decodedResponse.data.count)
                            joseiData.append(contentsOf: Temp)
                            Temp.removeAll()
                            //print("Josei: \(joseiData!)")
                        }
                    }
                    else if Genre == "seinen"
                    {
                        //seinenData = decodedResponse.data //This works!!!!
                        Task
                        {
                            Trans(Data: decodedResponse.data, Storage: seinenData, Max: decodedResponse.data.count)
                            seinenData.append(contentsOf: Temp)
                            Temp.removeAll()
                        }
                    }
                }
                   
            }
            //print("Data: \(decodedResponse?.data)")
            
        }
        catch let error
        {
            print("ERROR = \(error.localizedDescription)")
        }
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
                    
                   
                    /*self.chapterCount = decodedResponse.data[Index].count //Number of Chapters
                    self.chapterId = decodedResponse.data[Int].id// Specific Chapter Id
                    self.chapterTitle = decodedResponse.data[Int].attributes.title //Chapter Title
                    self.chapterNumber = decodedResponse.data[Int].attributes.chapter //Chapter Number
                    self.chapters = decodedResponse.data[index].attributes.pages // Number of pages*/
                    //decodedResponse.data[3].attributes.pages
                    
                    
                }
                
            }
            print("There are \(decodedResponse?.data.count) chapters")
            print("Most Recent Chapter: \(decodedResponse?.data.last?.attributes.title)") //Chapter Title
            print("Most Recent Chapter #: \(decodedResponse?.data.last?.attributes.chapter)")
            print("Total is \(decodedResponse?.total)")
            print(decodedResponse?.data)
        }
        catch let error
        {
            print("ERROR = \(error.localizedDescription)")
        }
    }
    
    func fetchPage(chapterId: String) async
    {
        // create url
        guard let url = URL(string: "https://api.mangadex.org/at-home/server/\(chapterId)?forcePort443=false") //link to specific chapter
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
            let decodedResponse = try? newJSONDecoder().decode(PageResponse.self, from: data)
            if let decodedResponse = decodedResponse
            {
                DispatchQueue.main.async
                {
                    self.pages = decodedResponse//This works!!!!
                    
                    self.pageURL = decodedResponse.baseURL
                    self.pageHASH = decodedResponse.chapter.hash
                    self.pageDATA = decodedResponse.chapter.data
                    //print("\(decodedResponse.baseURL)/data/\(decodedResponse.chapter.hash)/\(decodedResponse.chapter.data[0])")
                    
                    //print("\(self.pageURL!)/data/\(self.pageHASH!)/\(self.pageDATA!.indices)")
                }
                
            }
            //print("\(decodedResponse!.baseURL)/data/\(decodedResponse!.chapter.hash)/\(decodedResponse!.chapter.data[0])")
            //print("\(pageURL)/data/\(pageHASH)/\(pageDATA)")
            //{ chapter .chapter.{ quality mode }.[*] }

        }
        catch let error
        {
            print("ERROR = \(error.localizedDescription)")
        }
    }
    
    func fetchDetails(mangaId: String , chapterId: String) async
    {
        await fetchChapter(mangaId: mangaId)
        await fetchPage(chapterId: chapterId)
    }
    

    
    func quickMaths(info: CollectionResponse.mangaCollection) throws -> Int //Function to return the relationship index of a cover art
    {
        var INC = 0
        
        while info.relationships[INC].type != "cover_art"
        {
            INC += 1
        }
        return INC
        
        //info.attributes.tags[].attributes.name.description == "Long Strip"|| "Web Comic"
    }
    
    func populatePage(ID: String) async throws -> Int
    {
        //chapters.removeAll()
        var INC: Int
        
        await fetchPage(chapterId: ID)
        INC = pages.chapter.data.count
        return INC
        
    }
    
    
    func populateChapter(ID: String, Title: String) async
    {
        chapters.removeAll()
        NC.removeAll()
        chapterOffset = 0
        
        await fetchChapter(mangaId: ID)
        while chapters.count != chapterTotal
        {
            await fetchChapter(mangaId: ID)
        }
        AppendChapters(ID: ID, Title: Title)
        print(ID)
        print("Number of chapters: \(chapters.count) / \(chapterTotal)")
        
        
        
    }
    
    func AppendChapters(ID: String, Title: String)
    {
        for i in chapters.indices
        {
            let E = CRUDManager.shared.createChapter(id: chapters[i].id, title: chapters[i].attributes.title ?? "", chapterNumber: chapters[i].attributes.chapter ?? "", pages: Int(chapters[i].attributes.pages), publishDate: chapters[i].attributes.publishAt)
            NC.append(E)
            //Manga.addToChapters(E)
        }
    }
    
    
    func Trans(Data: [CollectionResponse.mangaCollection], Storage: [Manga], Max: Int) // This function will attempt to transform CollectionResponse.MangaCollection to Manga
    {
        var i = 0
        var j = 0
        var Tags: [Tag] = [Tag]()
        
        
        while i != Max
        {
            let X = Data[i].relationships[0]
            let Y = Data[i].relationships[1]
            let Z = try! self.quickMaths(info: Data[i])
            let tagCount = Data[i].attributes.tags.count
            Tags.removeAll()
            
            while j != tagCount
            {
                let W = CRUDManager.shared.getTags(Source: Data[i].attributes.tags[j])
                Tags.append(W)
                j += 1
            }
            j = 0
            
            let Id = Data[i].id
            let Title = Data[i].attributes.title!.en ?? Data[i].attributes.title!.ja ?? Data[i].attributes.title!.jaRo ?? Data[i].attributes.title!.ko ?? Data[i].attributes.title!.zh ?? Data[i].attributes.altTitles?.first?.en
            let Author = CRUDManager.shared.getAuthor(Source: X)
            let Artist = CRUDManager.shared.getArtist(Source: Y)
            let Cover = "https://uploads.mangadex.org/covers/\(Id)/\(Data[i].relationships[Z].attributes!.fileName ?? "")"
            let Status = Data[i].attributes.status!.capitalized
            let Synopsis = Data[i].attributes.attributesDescription.debugDescription.description
            
           
            //print("Title: \(Title)")
            //Task{
            let NewManga = CRUDManager.shared.findManga(id: Id, title: Title ?? "", author: Author, artist: Artist, cover: Cover, status: Status, synopsis: Synopsis, tags: Tags)
            if Storage.contains(where: { $0.id == NewManga.id})
            {
                print(NewManga.title, " is already saved")
            }
            else
            {
                Temp.append(NewManga)
//                if Data[i].attributes.publicationDemographic == "shounen"
//                {
//                    CRUDManager.shared.addShounen(Manga: NewManga)
//                }
            }
            
            i += 1
            
        }
        
        
    }
    
    
    func searchManga(searchValue: String) async -> [Manga]
    {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.mangadex.org"
        components.path = "/manga"
        components.queryItems = [
            URLQueryItem(name: "limit", value: "100"),
            URLQueryItem(name: "offset", value: "0"),
            URLQueryItem(name: "title", value: searchValue),
            //URLQueryItem(name: "includedTagsMode", value: "AND"),
            //URLQueryItem(name: "excludedTagsMode", value: "OR"),
            //URLQueryItem(name: "availableTranslatedLanguage[]", value: "en"),
            //URLQueryItem(name: "contentRating[]", value: "safe"),
            //URLQueryItem(name: "contentRating[]", value: "suggestive"),
            //URLQueryItem(name: "contentRating[]", value: "erotica"),
            //URLQueryItem(name: "order[latestUploadedChapter]", value: "desc"),
            URLQueryItem(name: "includes[]", value: "author"),
            URLQueryItem(name: "includes[]", value: "artist"),
            URLQueryItem(name: "includes[]", value: "cover_art")
        ]
        // create url
        guard let url = components.url
        else
        {
            print("Error")
            return []
        }
        print(url)
        // fetch data from url
        do
        {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            // decode data
            let decodedResponse = try? newJSONDecoder().decode(CollectionResponse.self, from: data)
            if let decodedResponse = decodedResponse
            {
                
                DispatchQueue.main.async
                { [self] in
                
                    Task
                    {
                        await Trans(Data: decodedResponse.data, Storage: searchResults, Max: decodedResponse.data.count)
                        searchResults = Temp
                        Temp.removeAll()
                    }
                    
                }
                
            }
        }
        catch let error
        {
            print("ERROR = \(error.localizedDescription)")
        }
        
        return searchResults ?? []
    }
    
    func searchByTag(Tag_ID: String?) async
    {
        //specificData.removeAll()
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.mangadex.org"
        components.path = "/manga"
        components.queryItems = [
            URLQueryItem(name: "limit", value: "\(LIMIT)" ),
            URLQueryItem(name: "offset", value: "\(OFFSET)" ),
            URLQueryItem(name: "includedTags[]", value: Tag_ID),
            //URLQueryItem(name: "contentRating[]", value: "pornographic"),
            URLQueryItem(name: "order[latestUploadedChapter]", value: "desc"),
            URLQueryItem(name: "includes[]", value: "author"),
            URLQueryItem(name: "includes[]", value: "artist"),
            URLQueryItem(name: "includes[]", value: "cover_art")
        ]
        
        guard let url = components.url
                
        else
        {
            print("Error")
            return
        }
        print(url)
        // fetch data from url
        do
        {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            // decode data
            let decodedResponse = try? newJSONDecoder().decode(CollectionResponse.self, from: data)
           
            if let decodedResponse = decodedResponse
            {
                TOTAL = decodedResponse.total
                DispatchQueue.main.async
                { [self] in
                    
                    Task
                    {
                        Trans(Data: decodedResponse.data, Storage: specificData, Max: decodedResponse.data.count)
                        specificData.append(contentsOf: Temp)
                        Temp.removeAll()
                    }
                    
                }
                   
            }
            //print("Data: \(decodedResponse?.data)")
            
        }
        catch let error
        {
            print("ERROR = \(error.localizedDescription)")
        }
    }
    
    func getMoreTags(Tag_ID: String?) async
    {
        tagOFFSET += 100
        OFFSET = tagOFFSET
        if OFFSET <= TOTAL //If Offest is less than or equal to Total, run code
        {
            print("\(OFFSET)/\(TOTAL)")
            await searchByTag(Tag_ID: Tag_ID)
        }
    }
    
    func searchByAuthor(Author_ID: String?) async
    {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.mangadex.org"
        components.path = "/manga"
        components.queryItems = [
            //URLQueryItem(name: "limit", value: "100"),
            //URLQueryItem(name: "offset", value: "0"),
            URLQueryItem(name: "authors[]", value: Author_ID),
            //URLQueryItem(name: "contentRating[]", value: "pornographic"),
            URLQueryItem(name: "order[latestUploadedChapter]", value: "desc"),
            URLQueryItem(name: "includes[]", value: "author"),
            URLQueryItem(name: "includes[]", value: "artist"),
            URLQueryItem(name: "includes[]", value: "cover_art")
        ]
        
        guard let url = components.url
                
        else
        {
            print("Error")
            return
        }
        print(url)
        // fetch data from url
        do
        {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            // decode data
            let decodedResponse = try? newJSONDecoder().decode(CollectionResponse.self, from: data)
            TOTAL = decodedResponse!.total
            if let decodedResponse = decodedResponse
            {
                print("Total is \(decodedResponse.total)")
                DispatchQueue.main.async
                { [self] in
                    
                    Task
                    {
                        Trans(Data: decodedResponse.data, Storage: specificData, Max: decodedResponse.data.count)
                        specificData.append(contentsOf: Temp)
                        Temp.removeAll()
                    }
                    
                }
                   
            }
            //print("Data: \(decodedResponse?.data)")
            
        }
        catch let error
        {
            print("ERROR = \(error.localizedDescription)")
        }
    }
    
    func searchByArtist(Artist_ID: String?) async
    {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.mangadex.org"
        components.path = "/manga"
        components.queryItems = [
            //URLQueryItem(name: "limit", value: "100"),
            //URLQueryItem(name: "offset", value: "0"),
            URLQueryItem(name: "artists[]", value: Artist_ID),
            //URLQueryItem(name: "contentRating[]", value: "pornographic"),
            URLQueryItem(name: "order[latestUploadedChapter]", value: "desc"),
            URLQueryItem(name: "includes[]", value: "author"),
            URLQueryItem(name: "includes[]", value: "artist"),
            URLQueryItem(name: "includes[]", value: "cover_art")
        ]
        
        guard let url = components.url
                
        else
        {
            print("Error")
            return
        }
        print(url)
        // fetch data from url
        do
        {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            // decode data
            let decodedResponse = try? newJSONDecoder().decode(CollectionResponse.self, from: data)
            TOTAL = decodedResponse!.total
            if let decodedResponse = decodedResponse
            {
                DispatchQueue.main.async
                { [self] in
                    
                    Task
                    {
                        Trans(Data: decodedResponse.data, Storage: specificData, Max: decodedResponse.data.count)
                        specificData.append(contentsOf: Temp)
                        Temp.removeAll()
                    }
                    
                }
                   
            }
            //print("Data: \(decodedResponse?.data)")
            
        }
        catch let error
        {
            print("ERROR = \(error.localizedDescription)")
        }
    }
    
    func getManga(Manga_ID: String) async
    {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.mangadex.org"
        components.path = "/manga/\(Manga_ID)"
        components.queryItems = [
            //URLQueryItem(name: "limit", value: "100"),
            //URLQueryItem(name: "offset", value: "0"),
            //URLQueryItem(name: "authors[]", value: Manga_ID),
            URLQueryItem(name: "includes[]", value: "author"),
            URLQueryItem(name: "includes[]", value: "artist"),
            URLQueryItem(name: "includes[]", value: "cover_art")
        ]
        
        guard let url = components.url
                
        else
        {
            print("Error")
            return
        }
        print(url)
        // fetch data from url
        do
        {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            // decode data
            let decodedResponse = try? newJSONDecoder().decode(MangaResponse.self, from: data)
            
            if let decodedResponse = decodedResponse
            {
    
                DispatchQueue.main.async
                { [self] in
                    
                    
                        
                        var INC = 0
                        
                        while decodedResponse.data.relationships[INC].type != "cover_art"
                        {
                            INC += 1
                        }
                        
                        
                        newCover = "https://uploads.mangadex.org/covers/\(Manga_ID)/\(decodedResponse.data.relationships[INC].attributes!.fileName ?? "")"
                        
                    print(newCover)
                    
                }
                   
            }
            //print("Data: \(decodedResponse?.data)")
            
        }
        catch let error
        {
            print("ERROR = \(error.localizedDescription)")
        }
    }
    
}


//https://api.mangadex.org/chapter?limit=100&manga=26937cf3-0fba-4651-995d-5ebcc8a15eb2
