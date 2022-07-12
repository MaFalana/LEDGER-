//
//  viewAll.swift
//  Ledger 0.1.2
//
//  Created by Malik Falana on 6/4/22.
//

import SwiftUI

struct viewMore: View
{
    @EnvironmentObject var network: CollectionLoader

    let Genre: String
    var Data: [Manga]
    var Title: String
    {
        if Genre == ""
        {
           return "Recently Updated"
        }
        else
        {
            return Genre
        }
        
    }
    
    @State private var sheetPresented = false
    let Column = Array(repeating: GridItem(.adaptive(minimum: 50), spacing: 25, alignment: .leading), count: 3)
    
    var body: some View
    {
        
        
        ScrollView(.vertical)
        {
            
            LazyVGrid(columns: Column)
            {
                ForEach( Data )
                {
                    item in
                    
                    mangaCell(item: item)
                    .onAppear
                    {
                        if item == Data.last //If last item is in view
                        {
                            Task
                            {
                                await network.loadAll(Genre: Genre) // More items will be loaded
                            }
                        }
                    }
                }
                
            }
            Text("\(network.TOTAL) total results").font(.footnote)
                
        }
        .navigationTitle(Title)
    }
}






struct mangaCell: View
{
    @EnvironmentObject var network: CollectionLoader
    var item: Manga
    
    var body: some View
    {
        VStack
        {
                                            
            NavigationLink(destination: Profile(info: item).environmentObject(network)) //link to profile page
            {
                BrowseView(urlString: item.cover!).cornerRadius(10)
            }
            Text(item.title).bold().frame(width: 120).lineLimit(1)
        }
            Spacer()
    }
}


struct viewTag: View
{
    @EnvironmentObject var network: CollectionLoader

    var Genre: Tag
    var Data: [Manga]
    {
        return network.specificData
    }
    var Title: String
    {
        return Genre.name!
    }
    
    @State private var sheetPresented = false
    let Column = Array(repeating: GridItem(.adaptive(minimum: 50), spacing: 25, alignment: .leading), count: 3)
    
    var body: some View
    {
        
        
        ScrollView(.vertical)
        {
            
            
            LazyVGrid(columns: Column)
            {
                ForEach( Data )
                {
                    item in
                    
                    mangaCell(item: item)
                    .onAppear
                    {
                        if item == Data.last //If last item is in view
                        {
                            Task
                            {
                                await network.getMoreTags(Tag_ID: Genre.id) // More items will be loaded
                            }
                        }
                    }
                }
                
            }
            
            Text("\(network.TOTAL) total results").font(.footnote)
                
        }
        .navigationTitle(Title)
        .navigationBarTitleDisplayMode(.large)
        .task{ network.specificData.removeAll(); await network.searchByTag(Tag_ID: Genre.id) }
    }
}

struct viewAuthor: View
{
    @EnvironmentObject var network: CollectionLoader

    var Author: Author
    var Data: [Manga]
    {
        return network.specificData
    }
    var Title: String
    {
        return Author.name!
    }
    
    @State private var sheetPresented = false
    let Column = Array(repeating: GridItem(.adaptive(minimum: 50), spacing: 25, alignment: .leading), count: 3)
    
    var body: some View
    {
        
        
        ScrollView(.vertical)
        {
            
            LazyVGrid(columns: Column)
            {
                ForEach( Data )
                {
                    item in
                    
                    mangaCell(item: item)
                }
                
            }
            Text("\(network.TOTAL) total results").font(.footnote)
        }
        .navigationTitle(Title)
        .navigationBarTitleDisplayMode(.large)
        .task{ network.specificData.removeAll(); await network.searchByAuthor(Author_ID: Author.id) }
    }
}

struct viewArtist: View
{
    @EnvironmentObject var network: CollectionLoader

    var Artist: Artist
    var Data: [Manga]
    {
        return network.specificData
    }
    var Title: String
    {
        return Artist.name!
    }
    
    @State private var sheetPresented = false
    let Column = Array(repeating: GridItem(.adaptive(minimum: 50), spacing: 25, alignment: .leading), count: 3)
    
    var body: some View
    {
        
        
        ScrollView(.vertical)
        {
            
            LazyVGrid(columns: Column)
            {
                ForEach( Data )
                {
                    item in
                    
                    mangaCell(item: item)
                }
                
            }
            Text("\(network.TOTAL) total results").font(.footnote)
        }
        .navigationTitle(Title)
        .navigationBarTitleDisplayMode(.large)
        .task{ network.specificData.removeAll(); await network.searchByArtist(Artist_ID: Artist.id) }
    }
}

//class MemberData: ObservableObject
//{
//    @Published var members = [Manga]()
//
//    // Tells if all records have been loaded. (Used to hide/show activity spinner)
//    var membersListFull = false
//    // Tracks last page loaded. Used to load next page (current + 1)
//    var currentPage = 0
//    // Limit of records per page. (Only if backend supports, it usually does)
//    let perRequest = 20
//
//    let url = URL(string: "https://testURL.com?page=\(currentPage+1)&perPage=\(perRequest)")!
//    private var cancellable: AnyCancellable?
//
//    func fetchMembers()
//    {
//        cancellable = URLSession.shared.dataTaskPublisher(for: url)
//        .tryMap { $0.data }
//        .decode(type: [Manga].self, decoder: JSONDecoder())
//        .receive(on: RunLoop.main)
//        .catch { _ in Just(self.members) }
//        .sink
//        {
//            [weak self] in
//            self?.currentPage += 1
//            self?.members.append(contentsOf: $0)
//
//            // If count of data received is less than perRequest value then it is last page.
//            if $0.count < perRequest
//            {
//                self?.membersListFull = true
//            }
//        }
//    }
//}
