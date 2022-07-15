//
//  ChapterList View.swift
//  Ledger 0.1.2
//
//  Created by Malik Falana on 6/1/22.
//

import SwiftUI

struct ChapterListView: View
{
    @EnvironmentObject var network: CollectionLoader
    //@EnvironmentObject var libraryManager: LibraryManager
    //@EnvironmentObject var crudManager: CRUDManager
    @EnvironmentObject private var themeManager: ThemeManager
    
    @StateObject var quequedManga: Manga
    var ID: String
    {
        return quequedManga.id
    }
    var ChapterList: [Chapter]
    {
//        if quequedManga.chapters?.count == 0
//        {
//            return network.NC
//        }
//        else
//        {
//            return Array(_immutableCocoaArray: quequedManga.chapters ?? [] )
//        }
        return Array(_immutableCocoaArray: quequedManga.chapters ?? [] )

    }
    var Header: String
    {
        if ChapterList.count == 0
        {
            return "No Chapters"
        }
        else
        {
            return "Chapters"
        }
    }
    
    @State var N: Int = 0
    @State var showSheet: Bool = false
    
    var body: some View
    {
        
        Text(Header).fontWeight(.bold).frame(width: 415, alignment: .leading)
        Divider() // Third Divider
        ForEach(ChapterList, id: \.id)
        {
            i in
            
            Button(action: { N = 0 ; showSheet.toggle(); CRUDManager.shared.updateHistory(Source: ChapterList[N]) } )
            {
                ChapterRow(Manga: quequedManga, Chapter: i)
                
                
                    
            }
            .fullScreenCover(isPresented: $showSheet, content: {FC(ReaderTitle: i.title!, ChapterID: i.id!, MangaID: i.source!.id, Pages: Int(i.pages)).accentColor(themeManager.selectedTheme.accent).environmentObject(network)} )
            Divider()
            
        }
        .listStyle(.plain)
        
        
    }
}
