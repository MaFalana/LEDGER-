//
//  Search Page.swift
//  Ledger
//
//  Created by Malik Falana on 4/29/22.
//

import Foundation
import UIKit
import SwiftUI

struct Search: View
{
    @StateObject private var shonenList = ShonenListViewModel()
    
    @EnvironmentObject private var themeManager: ThemeManager
   
    @EnvironmentObject var network: CollectionLoader
    @State private var searchText: String = ""
    @State private var term: String = "Popular"
    @State var Results: [Manga] = []
    
    //@State var up: Bool = false
    //ScrollView(up ? .vertical : .horizontal)
    
   // init() { UITableView.appearance().backgroundColor = UIColor(ThemeManager.shared.selectedTheme.background) }
    
    var body: some View
    {
        ZStack
        {
            themeManager.selectedTheme.background.ignoresSafeArea(.all)
            ScrollView(.vertical)
            {
    //            HStack
    //            {
    //                //Button {} label: {Image(systemName: "line.3.horizontal.decrease") }
    //                Text("List").foregroundColor(.gray)
    //
    //                HStack
    //                {
    //                    Menu
    //                    {
    //                        Button("Popular") { term = "Popular" }
    //                        Button("Latest") { term = "Latest" }
    //                        Button("All") { term = "All" }
    //                    }
    //                    label:
    //                    {
    //                        Text(term).animation(.easeIn)
    //                        Image(systemName: "chevron.down")
    //                    }
    //                }
    //
    //                Spacer()
    //                Button {} label: {Image(systemName: "line.3.horizontal.decrease") }.imageScale(.large)
    //
    //            }.padding()
                
                ForEach(network.searchResults)
                {
                    item in

                    NavigationLink(destination: Profile(info: item).environmentObject(network))
                    {
                        searchRow(info: item)
                        //item.attributes.altTitles
                    }//.listStyle(.plain)
                    Divider()
                }.searchable(text: $searchText).onChange(of: searchText ){
                    value in
                    Task
                    {
                        //await network.searchManga(searchValue: searchText)
                        if !value.isEmpty && value.count > 3
                        {
                            //await shonenList.search(name: value)
                            await network.searchManga(searchValue: searchText)
                        }
                        else
                        {
                            //shonenList.sample.removeAll()
                            network.searchResults.removeAll()
                        }
                    }
                    
                }
            }.background(themeManager.selectedTheme.background).navigationTitle("Search")
        }
        
      
    }
    
    
        
}
    
@MainActor class ShonenListViewModel: ObservableObject
{
    @Published var sample: [Manga] = []
    func search(name: String) async
    {
        
            print("Before: \(sample)")
            //let mangas = try await Webservice().getShonen(searchTerm: name)
            
            let mangas = try? await Webservice().getShonen(searchTerm: name)
            if let mangas = mangas
            {
                DispatchQueue.main.async
                {
                    self.sample = mangas //This works!!!!
                }
            }
            
            //print(mangas)
            //self.sample = mangas.map(ShonenViewModel.init)
            print("After: \(sample)")
    }
}


class Webservice
{
    @Published var shonen: [Manga]? = [Manga]()
    @Published var Temp: [Manga]! = [Manga]()
    @EnvironmentObject var network: CollectionLoader
    
    func getShonen(searchTerm: String) async throws -> [Manga]
    {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.mangadex.org"
        components.path = "/manga"
        components.queryItems = [
            URLQueryItem(name: "limit", value: "100"),
            URLQueryItem(name: "offset", value: "0"),
            URLQueryItem(name: "title", value: searchTerm.trimmed()),
            //URLQueryItem(name: "includedTagsMode", value: "AND"),
            //URLQueryItem(name: "excludedTagsMode", value: "OR"),
            //URLQueryItem(name: "availableTranslatedLanguage[]", value: "en"),
            //URLQueryItem(name: "contentRating[]", value: "safe"),
            //URLQueryItem(name: "contentRating[]", value: "suggestive"),
            //URLQueryItem(name: "contentRating[]", value: "erotica"),
            URLQueryItem(name: "order[latestUploadedChapter]", value: "desc"),
            URLQueryItem(name: "includes[]", value: "author"),
            URLQueryItem(name: "includes[]", value: "artist"),
            URLQueryItem(name: "includes[]", value: "cover_art")
        ]
        guard let url = components.url else
        {
            print("Error")
            return []
        }
        
        do
        {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            let decodedResponse = try? newJSONDecoder().decode(CollectionResponse.self, from: data)
            
            if let decodedResponse = decodedResponse
            {
                Task
                {
                    await Trans(Data: decodedResponse.data, Max: decodedResponse.data.count)
                    shonen = Temp
                    //print(shonen[0].title)
                    Temp.removeAll()
                }
            }
            
        }
        catch let error
        {
            print("ERROR = \(error.localizedDescription)")
        }
        
        
        return shonen ?? []
        
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
    
    func Trans(Data: [CollectionResponse.mangaCollection], Max: Int) async // This function will attempt to transform CollectionResponse.MangaCollection to Manga
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
            let Title = Data[i].attributes.title!.en ?? Data[i].attributes.title!.jaRo
            let Author = CRUDManager.shared.getAuthor(Source: X)
            let Artist = CRUDManager.shared.getArtist(Source: Y)
            let Cover = "https://uploads.mangadex.org/covers/\(Id)/\(Data[i].relationships[Z].attributes!.fileName ?? "")"
            let Status = Data[i].attributes.status!.capitalized
            let Synopsis = String(describing: Data[i].attributes.attributesDescription)
            
            
            
            //print("Title: \(Title)")
            //Task{
            let NewManga = CRUDManager.shared.findManga(id: Id, title: Title ?? "", author: Author, artist: Artist, cover: Cover, status: Status, synopsis: Synopsis, tags: Tags)
                
                Temp.append(NewManga)
                //joseiData.append(NewManga)
                //print(joseiData.first)
            
            //}
            
            i += 1
            
        }
        
        
    }
   
}


enum NetworkError: Error
{
    case badURL
    case badID
}

extension String
{
    func trimmed() -> String
    {
        self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}



