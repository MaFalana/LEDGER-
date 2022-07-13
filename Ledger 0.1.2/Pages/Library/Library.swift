//
//  LibraryView.swift
//  Ledger 0.1.2
//
//  Created by Malik Falana on 6/9/22.
//

//import SlidingTabView
import Foundation
import SwiftUI



struct Library: View
{

    @EnvironmentObject var network: CollectionLoader
    @State  var selectedMangaIndex = 0
    
    //@EnvironmentObject var libraryManager: LibraryManager
    //@EnvironmentObject var coreDM: CoreDataManager
    //let libraryData: [CollectionResponse.mangaCollection]
    
    let libraryData: Lib
    
    @State private var sheetPresented = false
    @State private var searchText: String = ""
    //@State public var rowItems: Int = 3
    private var ASH: [Manga]
    {
        //return (libraryData.data ?? []) as! [Manga]
        return Array(_immutableCocoaArray: libraryData.data ?? [])
    }
    
    var body: some View
    {
        ScrollView(.vertical)
        {
            var columnLayout = Array(repeating: GridItem(), count: Sort_Menu().rowItems)
            
            
            LazyVGrid(columns: columnLayout, spacing: 7.25)
            {
                ForEach(ASH, id: \.id)
                {
                    item in
                    //let X = try! network.quickMaths(info: item)
                    VStack
                    {
                        NavigationLink(destination: Profile(info: item).environmentObject(network)  )
                        {

                            LibraryView(urlString: item.cover!, Library: libraryData, selectedManga: item)
                                .cornerRadius(10)
                        }

                        Text(item.title).bold().frame(width: 120).lineLimit(1)
                        Spacer()
                    }
                }

            }
            if ASH.count == 1
            {
                Text("\(ASH.count) title in collection").font(.footnote)
            }
            else
            {
                Text("\(ASH.count) titles in collection").font(.footnote)
            }

        }
        .task
        {
            for i in ASH
            {
                print("\(i.title)")
            }
        }
    }
    
    
    var searchResults: [Manga]
    {
        if searchText.isEmpty
        {
            return network.joseiData
        }
        else
        {
            return network.joseiData
            //return network.joseiData.filter { $0.contains(searchText) }
        }
    }

}
