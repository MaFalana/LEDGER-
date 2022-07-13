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
    
    //var info: CollectionResponse.mangaCollection
    var queuedManga: Manga
    
    //let id, title, author, artist, cover, status, synopsis: String
    
   
    
    var body: some View
    {
        //let Argus: [String] = [id, title, author, artist, cover, status, synopsis]
        
        //return X
        Divider() // Second Divider
        HStack
        {
            Button(action: {isAdding.toggle()} ) {Label("Add to Library", systemImage: "folder.badge.plus").padding()}
                .sheet(isPresented: $isAdding){ AddView(queuedManga: queuedManga) }
            Spacer()
        }
        HStack// 3 - 4 buttons
        {
    
            Button(action: {isReading.toggle()} ) { Label("Read", systemImage: "play").labelStyle(AdaptiveLabelStyle()).padding() }.fullScreenCover(isPresented: $isReading, content: {FC(ReaderTitle:"A Man's Resolve", ChapterID:"ed6ba867-0472-4f8f-af40-a2697fcd5cfc", MangaID:"316377a7-d44a-461b-903e-9faf917e2f8f", Pages:38, Index: 0, nums: [])} )
            
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

