//
//  ButtonView.swift
//  Ledger 0.1.2
//
//  Created by Malik Falana on 6/1/22.
//

import SwiftUI

struct ButtonView: View
{
    //@EnvironmentObject var DD: LibraryDataManager
    @EnvironmentObject var network: CollectionLoader
    @EnvironmentObject var crudManager: CRUDManager
    
    //let coreDM: CoreDataManager
    //@EnvironmentObject var coreDM: CoreDataManager
    @State var isAdding: Bool = false
    @State var isReading: Bool = false
    @State var isLoading: Bool = false
    @State var isPopulated: Bool = false
    
    //var info: CollectionResponse.mangaCollection
    var queuedManga: Manga
    
    //let id, title, author, artist, cover, status, synopsis: String
    
    
    var Chapter: [Chapter]
    {
        return Array(_immutableCocoaArray: queuedManga.chapters ?? [] )
    }
   
    
    var body: some View
    {
        //let Y = queuedManga.chapters?.firstObject as! Chapter
        //let Argus: [String] = [id, title, author, artist, cover, status, synopsis]
        
        //return X
        Divider() // Second Divider
        HStack
        {
            Button(action: {isAdding.toggle()} ) {Label("Add to Library", systemImage: "folder.badge.plus").padding()}
                .sheet(isPresented: $isAdding){ AddView(queuedManga: queuedManga) }
            Spacer()
            
            Button(action: {Task{await CRUDManager.shared.updateManga(Manga: queuedManga)} } ) {Label("Refresh", systemImage: "arrow.clockwise").padding()}
            
        }
        HStack// 3 - 4 buttons
        {
    
            Button(action: {isReading.toggle()} ) { Label("Read", systemImage: "play").labelStyle(AdaptiveLabelStyle()).padding() }.fullScreenCover(isPresented: $isReading, content: {FC(ReaderTitle: Chapter.first!.title!, ChapterID: Chapter.first!.id!, MangaID: Chapter.first!.source!.id, Pages: Int(Chapter.first!.pages) ).environmentObject(network).accentColor(ThemeManager.shared.selectedTheme.accent) } )
                .disabled(isPopulated)
                
                
            
            Spacer()
            Label("Chapters", systemImage: "book").labelStyle(AdaptiveLabelStyle()) //Chapter buttons
            Spacer()
            //Label("Bookmarks", systemImage: "bookmark").labelStyle(AdaptiveLabelStyle()).padding()
            
            
            NavigationLink(destination: Bookmarks(queuedManga: queuedManga) )
            {
                Label("Bookmarks", systemImage: "bookmark").labelStyle(AdaptiveLabelStyle()).padding()
            }

            //Bookmark buttons
        }
        .task
        {
            if Chapter.isEmpty
            {
                isPopulated.toggle()
            }
        }
    }
}



struct AdaptiveLabelStyle: LabelStyle
{
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @EnvironmentObject private var themeManager: ThemeManager
    
    func makeBody(configuration: Configuration) -> some View
    {
        if horizontalSizeClass == .compact
        {
            VStack
            {
                configuration.icon.foregroundColor(themeManager.selectedTheme.accent)
                configuration.title.foregroundColor(themeManager.selectedTheme.label)
            }
        }
        else
        {
            Label(configuration)
        }
    }
}


