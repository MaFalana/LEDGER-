//
//  PageModel.swift
//  Ledger.0.0.2
//
//  Created by Malik Falana on 5/29/22.
//

import Foundation
import SwiftUI

struct PageResponse: Codable
{
    let result: String
    let baseURL: String
    let chapter: Chapter

    enum CodingKeys: String, CodingKey
    {
        case result
        case baseURL = "baseUrl"
        case chapter
    }
    
    struct Chapter: Codable
    {
        let hash: String
        let data, dataSaver: [String]
    }
}


/*func fetchChapter() async
{
    // create url
    guard let url = URL(string: "https://api.mangadex.org/chapter?&manga=\(mangaId)") //link to specific chapter
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
                self.chapters = decodedResponse
                /*self.chapterCount = decodedResponse.data[Index].count //Number of Chapters
                self.chapterId = decodedResponse.data[Int].id// Specific Chapter Id
                self.chapterTitle = decodedResponse.data[Int].attributes.title //Chapter Title
                self.chapterNumber = decodedResponse.data[Int].attributes.chapter //Chapter Number
                self.chapters = decodedResponse.data[index].attributes.pages // Number of pages*/
                //decodedResponse.data[3].attributes.pages
            }
            
        }
        print(decodedResponse)
    }
    catch let error
    {
        print("ERROR = \(error.localizedDescription)")
    }
}*/



/*func fetchPage() async
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
                //self.pages = decodedResponse//This works!!!!
                
                self.pageURL = decodedResponse.baseURL
                self.pageHASH = decodedResponse.chapter.hash
                self.pageDATA = decodedResponse.chapter.data
            }
            
        }
        print("\(decodedResponse?.baseURL ?? "")/data/\(decodedResponse?.chapter.hash ?? "")/\(decodedResponse?.chapter.data[0] ?? "")")
        //{ chapter .chapter.{ quality mode }.[*] }

    }
    catch let error
    {
        print("ERROR = \(error.localizedDescription)")
    }
}*/
