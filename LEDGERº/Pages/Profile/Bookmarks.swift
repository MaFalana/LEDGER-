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
    @State private var showSheet = false
    @StateObject var queuedManga: Manga
    var Bookmark: [Chapter]
    {
        return Array(_immutableCocoaArray: queuedManga.bookmarks ?? [] )
    }
    
    var body: some View
    {
        
        List(Bookmark, id: \.id)
        {
            
            i in
            Button(action: {showSheet.toggle(); CRUDManager.shared.updateHistory(Source: i) } )
            {
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
                        
                            print("Remove Bookmark")
    //                        let preCount = queuedManga.bookmarks?.count
    //                        let postCount = preCount! - 1
                            for j in queuedManga.chapters!
                            {
                                if (j as! Chapter).id == i.id
                                {
                                    (j as! Chapter).isBookmarked.toggle()
                                }
                            }
                            queuedManga.removeFromBookmarks(i)
                            //CRUDManager.shared.fetchLibraries()
                            //CRUDManager.shared.Save()
    //                        queuedManga.bookmarks?.count = postCount
                            //try CRUDManager.shared.viewContext.save()
                        
                        
                    }
                    label:
                    {
                        Label("Remove Bookmark", systemImage: "bookmark.slash")
                    }.tint(.yellow)
                }
            }
            .fullScreenCover(isPresented: $showSheet, content: {FC(Chapter: i).accentColor(themeManager.selectedTheme.accent)} )
            
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


struct SavedChapters: View
{
    @EnvironmentObject private var themeManager: ThemeManager
    @StateObject var queuedManga: Manga
    @State var showAlert: Bool = false
    
    var Chapters: [Chapter]
    {
        return Array(_immutableCocoaArray: queuedManga.chapters ?? [] )
    }
    var Title: String
    {
        if Chapters.isEmpty
        {
            return "No Chapters"
        }
        else
        {
            return "\(Chapters.count) Chapters"
        }
        
    }
    
    var body: some View
    {
        
        List(Chapters, id: \.id)
        {
            
            i in
            
            Saved(Chapter: i)
            .swipeActions(edge: .leading, allowsFullSwipe: false)
            {
                Button
                {
                    print("Deleting Chapter")
                    queuedManga.removeFromSaved(i)
                    CRUDManager.shared.Save()
                }
                label:
                {
                    Label("Delete", systemImage: "trash")
                    
                }.tint(.indigo)
                
                
                
                Button(
                    action:
                    {
                        if i.isBookmarked
                        {
                            queuedManga.removeFromBookmarks(i)
                            //print("\(i.title) un-bookmarked")
                        }
                        else
                        {
                            queuedManga.addToBookmarks(i)
                            //print("\(i.title) bookmarked")
                        }
                        CRUDManager.shared.Save()
                        i.isBookmarked.toggle()
                        
                    
                    } )
                {
                    Label(i.isBookmarked ? "Remove Bookmark" : "Bookmark", systemImage: i.isBookmarked ? "bookmark.slash" : "bookmark")
                    
                }.tint(.yellow)
                
                
                
                
            }
            
        }
        .navigationBarTitle(Title)
        .listStyle(.insetGrouped)
        .background(themeManager.selectedTheme.background)
        .refreshable
        {
            print(queuedManga)
            await CRUDManager.shared.updateManga(Manga: queuedManga)
            showAlert.toggle()
        }
        .alert(isPresented: $showAlert)
        {
            Alert5()
        }
    }
        
    
}


struct Saved: View
{
    @EnvironmentObject var themeManager: ThemeManager
    @State var showSheet: Bool = false
    
    let Chapter: Chapter
    
    var Title: String // Chapter title
    {
        return Chapter.title!
    }
    var Num: String // Chapter Number
    {
        return Chapter.chapterNumber!
    }
    var Date: Date // Date read/ added to array
    {
        return Chapter.publishDate!
    }
    var ID: String
    {
        return Chapter.id!
    }
    var SourceID: String
    {
        return Chapter.source!.id
    }
    var Pages: Int
    {
        return Int(Chapter.pages)
    }

    var body: some View
    {
        Button(action: {showSheet.toggle(); CRUDManager.shared.updateHistory(Source: Chapter) } )
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
        .fullScreenCover(isPresented: $showSheet, content: {FC(Chapter: Chapter).accentColor(themeManager.selectedTheme.accent)} )
        
        //.fullScreenCover(isPresented: $showSheet, content: {offlineReader(ReaderTitle: Title, ChapterID: ID, MangaID: SourceID, Pages: Pages).accentColor(themeManager.selectedTheme.accent)} )
        
        
    }
}
