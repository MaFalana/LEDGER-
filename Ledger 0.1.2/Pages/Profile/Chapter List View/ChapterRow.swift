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
    let Manga: Manga
    let Chapter: Chapter
    @State var Bookmarked: Bool = false
    @State var isBookmarked: Bool = false
    
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
    
    //,format: .dateTime.month().day().year()
 
    var body: some View
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
            Text("\(Date,format: .dateTime.month().day().year())").foregroundColor(.gray).font(.caption2).padding() //Date chapter was added
        }
        .task
        {
            isBookmarked = Manga.bookmarks!.contains(where: {($0 as AnyObject).id == Chapter.id})
        }
        .contextMenu
        {
            
            
            Button(
                action:
                {
                    if isBookmarked
                    {
                        Manga.removeFromBookmarks(Chapter)
                        //print("\(Chapter.title) un-bookmarked")
                    }
                    else
                    {
                        Manga.addToBookmarks(Chapter)
                        //print("\(Chapter.title) bookmarked")
                    }
                    CRUDManager.shared.Save()
                    isBookmarked = Manga.bookmarks!.contains(where: {($0 as AnyObject).id == Chapter.id})
                
                } )
            {
                Label(isBookmarked ? "Remove Bookmark" : "Bookmark", systemImage: isBookmarked ? "bookmark.slash" : "bookmark")
                
            }
            
            Button(action: {print("Download"); Task{await CRUDManager.shared.downloadChapter(Manga: Manga, Chapter: Chapter)} } )
            {
                Label("Download", systemImage: "square.and.arrow.down")
            }
        }
       
        
        
    }
}


