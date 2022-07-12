//
//  Mangakakalot.swift
//  Ledger 0.1.2
//
//  Created by Malik Falana on 6/27/22.
//

import Foundation


struct List_Mangakakalot: Codable
{
    let message: String
    let data: [Manga]
    
    struct Manga: Codable
    {
        let id: String
        let thumbnail_url: String
        let title: String
        let latest_chapter_title: String
        let latest_chapter_url: String
        let latest_chapter: Int
        let views_count: Int
        let authors: [String]
        let last_updated: String
        let url: String
    }
}




struct Specific_Mangakakalot: Codable
{
    let message: String
    let data: [Manga]
    
    struct Manga: Codable
    {
        let title: String
        let alternative_titles: [String]
        let description: String
        let authors: [String]
        let status: String
        let last_updated: String
        let views_count: String
        let genres: [String]
        let rating: String
        let rating_count: Int
        let chapters: [Chapter]
        
        struct Chapter: Codable
        {
            let id: String
            let title: String
            let url: String
            let number: Int
            let views_count: Int
            let uploaded_at: String
        }
    }
}







class MM: ObservableObject
{
    @Published var Retrieved: [List_Mangakakalot.Manga]! = [List_Mangakakalot.Manga]()
    let headers = [
        "X-RapidAPI-Key": "e2adbdf5cfmsh26cd2a40b430508p1faa55jsna3d5ba0e1b4e",
        "X-RapidAPI-Host": "manga-scraper-for-mangakakalot-website.p.rapidapi.com"
    ]
    
    func getList() // Gets a list of popular manga
    {
        let request = NSMutableURLRequest(url: NSURL(string: "https://manga-scraper-for-mangakakalot-website.p.rapidapi.com/popular")! as URL,
                                                cachePolicy: .useProtocolCachePolicy,
                                            timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler:
        {
            (data, response, error) -> Void in
            if (error != nil)
            {
                print(error)
            }
            else
            {
                let httpResponse = response as? HTTPURLResponse
                print(httpResponse)
                
            }
        })

        dataTask.resume()
        
        
    }
    
    func getManga(mangaID: String) // Gets a particular manga details
    {
        let request = NSMutableURLRequest(url: NSURL(string: "https://manga-scraper-for-mangakakalot-website.p.rapidapi.com/details?id=\(mangaID)")! as URL,
                                                cachePolicy: .useProtocolCachePolicy,
                                            timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                print(error)
            } else {
                let httpResponse = response as? HTTPURLResponse
                print(httpResponse)
            }
        })

        dataTask.resume()
        print(dataTask)
    }
    
    func getChapter(chapterID: String) // Gets all images for a specifc chapter
    {
        let request = NSMutableURLRequest(url: NSURL(string: "https://manga-scraper-for-mangakakalot-website.p.rapidapi.com/chapter?id=\(chapterID)")! as URL,
                                                cachePolicy: .useProtocolCachePolicy,
                                            timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                print(error)
            } else {
                let httpResponse = response as? HTTPURLResponse
                print(httpResponse)
            }
        })

        dataTask.resume()
    }
    
    func getList2() async
    {
        
        guard let url = URL(string: "https://manga-scraper-for-mangakakalot-website.p.rapidapi.com/popular")
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
            let decodedResponse = try? newJSONDecoder().decode(List_Mangakakalot.self, from: data)
            if let decodedResponse = decodedResponse
            {
                DispatchQueue.main.async
                {
                    self.Retrieved = decodedResponse.data
                    print(decodedResponse)
                }
                
            }
            
            print(Retrieved ?? [])
        }
        catch let error
        {
            print("ERROR = \(error.localizedDescription)")
        }
    }
    
    func Search(Keyword: String) // Search for manga by keyword
    {
        let request = NSMutableURLRequest(url: NSURL(string: "https://manga-scraper-for-mangakakalot-website.p.rapidapi.com/search?keyword=\(Keyword)&page=1")! as URL,
                                                cachePolicy: .useProtocolCachePolicy,
                                            timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler:
        { (data, response, error) -> Void in
            if (error != nil)
            {
                print(error)
            }
            else
            {
                let httpResponse = response as? HTTPURLResponse
                print(httpResponse)
            }
        })

        dataTask.resume()
    }
    
    func getList3() async
    {
        guard let url = URL(string: "https://manga-scraper-for-mangakakalot-website.p.rapidapi.com/popular")
        else
        {
            return
        }
        //let postData = postParams.data(using: .utf8) // Suggested by rmaddy
        var request = URLRequest(url: url)
        //let request =  NSMutableURLRequest(url: NSURL(string: accessTokenEndPoint)! as URL)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        let session = URLSession(configuration: URLSessionConfiguration.default)
        
        do
        {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            // decode data
            let decodedResponse = try? newJSONDecoder().decode(List_Mangakakalot.self, from: data)
            if let decodedResponse = decodedResponse
            {
                DispatchQueue.main.async
                {
                    self.Retrieved = decodedResponse.data
                    print(decodedResponse)
                }
                
            }
            
            print(Retrieved ?? [])
        }
        catch let error
        {
            print("ERROR = \(error.localizedDescription)")
        }
    }
}
