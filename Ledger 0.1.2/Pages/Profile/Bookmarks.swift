//
//  Bookmarks.swift
//  Ledger 0.1.2
//
//  Created by Malik Falana on 6/28/22.
//

import SwiftUI

struct Bookmarks: View
{
    @EnvironmentObject private var themeManager: ThemeManager
    var queuedManga: Manga
    var Bookmark: [Chapter]
    {
        return Array(_immutableCocoaArray: queuedManga.bookmarks ?? [] )
    }
    
    var body: some View
    {
        
        List
        {
            ForEach(Bookmark, id: \.id)
            {
                i in
                
                BookMark(Title: i.title!, Num: i.chapterNumber!, Date: i.publishDate!)
                    .swipeActions(edge: .leading, allowsFullSwipe: false)
                {
                    Button
                    {
                        print("Removing Bookmark")
                        queuedManga.removeFromBookmarks(i)
                    }
                    label:
                    {
                        Label("Remove", systemImage: "trash")
                        
                    }.tint(.indigo)
                    
                    Button
                    {
                        print("IDK")
                        //queuedManga.removeFromBookmarks(i)
                    }
                    label:
                    {
                        Label("Remove", systemImage: "bookmark")
                        
                    }.tint(.yellow)
                }
            }
        }
        .navigationBarTitle("Bookmarks")
        .listStyle(.insetGrouped)
        .background(themeManager.selectedTheme.background)
    }
}



struct BookMark: View
{
    @EnvironmentObject var themeManager: ThemeManager
    let Title: String // Chapter title
    let Num: String // Chapter Number
    let Date: Date // Date read/ added to array
    

    var body: some View
    {
        VStack
        {
            HStack
            {
                if Title == ""
                {
                    Text("Chapter \(Num)").font(.caption).padding()
                }
                else
                {
                    Text("Chapter \(Num): \(Title)").font(.caption).lineLimit(1).padding()
                }
                Spacer()
                Text(Date,format: .dateTime.month().day().year()).font(.caption2).padding()
            }.foregroundColor(.gray)
        }.foregroundColor(themeManager.selectedTheme.label)
    }
}
