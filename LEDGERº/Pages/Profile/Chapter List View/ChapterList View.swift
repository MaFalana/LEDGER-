//
//  ChapterList View.swift
//  Ledger 0.1.2
//
//  Created by Malik Falana on 6/1/22.
//

import SwiftUI
import WebKit

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
    @State var readChapter: Bool = false
    @State private var showAlert = false
    @State private var showWebView = false
    
    var body: some View
    {
        HStack
        {
            Text(Header).fontWeight(.bold).padding()
            Spacer()
            chapterSort().padding() // Chapter Sorting button
        }
        Divider() // Third Divider
        List(ChapterList)
        {
            i in
            
            Button(action: { N = 0 ; if i.pages != 0 { readChapter.toggle() } else{showWebView.toggle()}; CRUDManager.shared.updateHistory(Source: ChapterList[N]) } )
            {
                ChapterRow(Manga: quequedManga, Chapter: i)
       
            }
            .swipeActions(edge: .leading, allowsFullSwipe: false)
            {
                Button
                {
                    print("Deleting Chapter")
                    quequedManga.removeFromSaved(i)
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
                            quequedManga.removeFromBookmarks(i)
                            //print("\(i.title) un-bookmarked")
                        }
                        else
                        {
                            quequedManga.addToBookmarks(i)
                            //print("\(i.title) bookmarked")
                        }
                        CRUDManager.shared.Save()
                        i.isBookmarked.toggle()
                        
                    
                    } )
                {
                    Label(i.isBookmarked ? "Remove Bookmark" : "Bookmark", systemImage: i.isBookmarked ? "bookmark.slash" : "bookmark")
                    
                }.tint(.yellow)
                
                
                
                
            }
            .fullScreenCover(isPresented: $readChapter, content: {FC(Chapter: i).accentColor(themeManager.selectedTheme.accent).environmentObject(network)} )
            .sheet(isPresented: $showWebView)
            {
                WebView(url: URL(string: i.externalURL!)!)
            }
            //Divider()
            
        }
        .listStyle(.insetGrouped)
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 100, alignment: .center)
        //.listRowBackground(themeManager.selectedTheme.background)
        .refreshable
        {
            print(quequedManga)
            await CRUDManager.shared.updateManga(Manga: quequedManga)
            showAlert.toggle()
        }
        .alert(isPresented: $showAlert)
        {
            Alert5()
        }
        
        
    }
    
}



struct WebView: UIViewRepresentable {
 
    var url: URL
 
    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }
 
    func updateUIView(_ webView: WKWebView, context: Context) {
        let request = URLRequest(url: url)
        webView.load(request)
    }
}
