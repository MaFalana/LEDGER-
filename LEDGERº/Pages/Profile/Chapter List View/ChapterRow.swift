//
//  ChapterRow.swift
//  Ledger 0.1.2
//
//  Created by Malik Falana on 6/21/22.
//

import SwiftUI

struct ChapterRow: View
{
    @EnvironmentObject var themeManager: ThemeManager
    @EnvironmentObject var network: CollectionLoader
    let Manga: Manga
    let Chapter: Chapter
    @State var Bookmarked: Bool = false
    @State var isBookmarked: Bool = false
    
    @State private var showSheet = false
    @State private var showWebView = false
    
    var Title: String
    {
        return Chapter.title!
    }
    var Number: String
    {
        return Chapter.chapterNumber!
    }
    var Date: Date
    {
        return Chapter.publishDate!
    }
    
    private func readChapter()
    {
        if Chapter.pages != 0
        {
            showSheet.toggle()
        }
        else
        {
            showWebView.toggle()
        }
        CRUDManager.shared.createHistory(Chapter: Chapter)
    }
 
    var body: some View
    {
        Button(action: { readChapter() } )
        {
            HStack
            {
                if Title == ""
                {
                    Text("Chapter \(Number)").padding().foregroundColor(.gray).font(.caption2).lineLimit(1)
                }
                else
                {
                    Text("Chapter \(Number): \(Title)").padding().foregroundColor(.gray).font(.caption2).lineLimit(1)
                    
                }
                Spacer()
                Text(Date,format: .dateTime.month().day().year()).foregroundColor(.gray).font(.caption2).padding() //Date chapter was added
            }
        }
        .swipeActions(edge: .leading, allowsFullSwipe: false)
        {
            Button(
                action:
                {
                    if Chapter.isBookmarked
                    {
                        Manga.removeFromBookmarks(Chapter)
                        //print("\(i.title) un-bookmarked")
                    }
                    else
                    {
                        Manga.addToBookmarks(Chapter)
                        //print("\(i.title) bookmarked")
                    }
                    CRUDManager.shared.Save()
                    Chapter.isBookmarked.toggle()
                    
                
                } )
            {
                Label(Chapter.isBookmarked ? "Remove Bookmark" : "Bookmark", systemImage: Chapter.isBookmarked ? "bookmark.slash" : "bookmark")
                
            }.tint(.yellow)
            
            
            
            
        }
        .fullScreenCover(isPresented: $showSheet, content: {FC(Chapter: Chapter).accentColor(themeManager.selectedTheme.accent).environmentObject(network)} )
        .sheet(isPresented: $showWebView)
        {
            WebView(url: URL(string: Chapter.externalURL!)!)
        }
        .task
        {
            isBookmarked = Manga.bookmarks!.contains(where: {($0 as AnyObject).id == Chapter.id})
        }

    }
}


