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
    
    
    var quequedManga: Manga
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
        
        ScrollView(.vertical)
        {
            Divider() // Third Divider
            
            ForEach(ChapterList.indices) // Will need to populate an array of chapters
            {
                i in
                Button(action: { N = i ; showSheet.toggle(); CRUDManager.shared.updateHistory(Source: ChapterList[N]); quequedManga.addToBookmarks(ChapterList[N]) } )
                {
                    ChapterRow(Title: ChapterList[i].title!, Chapter: ChapterList[i].chapterNumber!, Date: ChapterList[i].publishDate! )
                    .swipeActions(allowsFullSwipe: false)
                    {
                        Button
                        {
                            print("Muting conversation")
                            //quequedManga.addToBookmarks(ChapterList[N])
                        }
                        label:
                        {
                            Label("Bookmark", systemImage: "bell.slash.fill")
                            
                        }.tint(.indigo)
                    }
                    
                        
                }
                .fullScreenCover(isPresented: $showSheet, content: {FC(ReaderTitle: ChapterList[N].title!, ChapterID: ChapterList[N].id! , MangaID: ID, Pages: Int(ChapterList[N].pages), Index: N, nums: [] ).accentColor(themeManager.selectedTheme.accent).environmentObject(network)} )
                Divider()
            }
        }//.refreshable { if (network.chapters.count >= 103) { await network.fetchChapter(mangaId: info.id) } }// Manga Title
        
    }
}
