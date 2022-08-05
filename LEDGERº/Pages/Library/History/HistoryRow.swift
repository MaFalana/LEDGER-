//
//  HistoryRow.swift
//  Ledger 0.1.2
//
//  Created by Malik Falana on 6/26/22.
//

import SwiftUI

struct HistoryRow: View
{
    @EnvironmentObject var themeManager: ThemeManager
    @EnvironmentObject var network: CollectionLoader
    @State private var showSheet = false
    @State private var showWebView = false
    let i: History
    
    var Title: String // Manga title
    {
        return (i.chapter?.source!.title)!
    }
    
    var Title2: String // Chapter title
    {
        let X = i.chapter!.title!
        
        if X == ""
        {
            return "Chapter \(i.chapter!.chapterNumber!)"
        }
        else
        {
            return "Chapter \(i.chapter!.chapterNumber!): \(X)"
        }
        
    }
    
    var Date: Date // Date read/ added to array
    {
        return i.readDate!
    }
    
    private func readChapter()
    {
        if i.chapter?.pages != 0
        {
            showSheet.toggle()
        }
        else
        {
            showWebView.toggle()
        }
        CRUDManager.shared.createHistory(Chapter: i.chapter!)
        CRUDManager.shared.changeChapter(X: i.chapter!)
    }
    

    var body: some View
    {

        Button( action: { readChapter()  } )
        {
            HStack
            {
                Text(Title2).font(.caption).lineLimit(1)
                Spacer()
                Text(Date,format: .dateTime.month().day().year()).font(.caption2).foregroundColor(.gray)
                Text(Date,style: .time).font(.caption2).foregroundColor(.gray)
            }
            
        }
        .fullScreenCover(isPresented: $showSheet, content: {FC().accentColor(themeManager.selectedTheme.accent).environmentObject(network)} )
        .sheet(isPresented: $showWebView)
        {
            WebView(url: URL(string: i.chapter!.externalURL!)!)
        }

    }
}


