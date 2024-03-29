//
//  LibraryView.swift
//  Ledger 0.1.2
//
//  Created by Malik Falana on 6/9/22.
//

//import SlidingTabView
import Foundation
import SwiftUI
//import Kingfisher



struct Library: View
{

    @EnvironmentObject var network: CollectionLoader
    @State var selectedMangaIndex = 0
    
    //@EnvironmentObject var libraryManager: LibraryManager
    //@EnvironmentObject var coreDM: CoreDataManager
    //let libraryData: [CollectionResponse.mangaCollection]
    
    var libraryData: Lib
    
    @State private var sheetPresented = false
    @State private var searchText: String = ""
    @State private var isHidden: Bool = CRUDManager.shared.isHidden
    @State private var rowItems = CRUDManager.shared.rowItems
    
    var ASH: [Manga]
//    {
//        //return (libraryData.data ?? []) as! [Manga]
//        return Array(_immutableCocoaArray: libraryData.data ?? [])
//    }
    
    
    var body: some View
    {
        ScrollView(.vertical)
        {
            let columnLayout = Array(repeating: GridItem(), count: CRUDManager.shared.rowItems)
            
            
            LazyVGrid(columns: columnLayout)
            {
                ForEach(searchResults, id: \.id)
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
        .toolbar
        {
            ToolbarItem(placement: .navigationBarTrailing)
            {
                Menu
                {
                    Button("3 Items") { rowItems = 3 }
                    Button("4 Items") { rowItems = 4 }
                    Button("5 Items") { rowItems = 5 }
                }
                label:
                {
                    Image(systemName: "square.stack.3d.up").imageScale(.large)
                }
            }
        }
        .searchable(text: $searchText)
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
            return ASH
        }
        else
        {
            return ASH.filter { $0.title.contains(searchText) || $0.author!.name!.contains(searchText) || $0.artist!.name!.contains(searchText) }
        }
    }

}

