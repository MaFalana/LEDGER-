//
//  Library ChapterList View.swift
//  Ledger 0.1.2
//
//  Created by Malik Falana on 6/19/22.
//

import SwiftUI

struct libChapterListView: View
{
    @EnvironmentObject var network: CollectionLoader
    @EnvironmentObject var crudManager: CRUDManager
    //@EnvironmentObject var libraryManager: LibraryManager
    @EnvironmentObject private var themeManager: ThemeManager
    
    let ID: String
    let ChapterList: [Chapter]
    //ChapterList.sorted(by: {$0.publishDate > $1.publishDate})
    @State var N: Int = 0
    @State var showSheet: Bool = false
    
    private var chapterTitle: String
    {
        ChapterList[0].title!
    }
    
    
    var body: some View
    {
        if ChapterList.count == 0
        {
            Text("No Chapters").fontWeight(.bold).frame(width: 415, alignment: .leading)
        }
        else
        {
            Text("Chapters").fontWeight(.bold).frame(width: 415, alignment: .leading)
            
            ScrollView(.vertical)
            {
                Divider() // Third Divider
                
                ForEach(ChapterList.indices) // Will need to populate an array of chapters
                {
                    i in
                    
                    
                    Button(action: { N = i ; showSheet.toggle() /*crudManager.History.append(ChapterList[N])*/ } )
                    {
                        ChapterRow(Title: ChapterList[i].title!, Chapter: ChapterList[i].chapterNumber!, Date: ChapterList[i].publishDate! )
                        .swipeActions(allowsFullSwipe: false)
                        {
                            Button
                            {
                                print("Muting conversation")
                                //quequedManga.addToBookmarks(network.chapters[N])
                            }
                            label:
                            {
                                Label("Mute", systemImage: "bell.slash.fill")
                                
                            }.tint(.indigo)
                        }
                            
                    }.fullScreenCover(isPresented: $showSheet, content: {FC(ReaderTitle: ChapterList[N].title!, ChapterID: ChapterList[N].id! , MangaID: ID, Pages: Int(ChapterList[N].pages), Index: N, nums: [] ).accentColor(themeManager.selectedTheme.accent).environmentObject(network)} )
                    Divider()
                }
                
            }
        }
    }
}
