//
//  ButtonView.swift
//  Ledger 0.1.2
//
//  Created by Malik Falana on 6/1/22.
//

import SwiftUI

struct ButtonView: View
{

    @EnvironmentObject var network: CollectionLoader
    @EnvironmentObject var crudManager: CRUDManager
    
    //let coreDM: CoreDataManager
    //@EnvironmentObject var coreDM: CoreDataManager
    @State private var isAdding: Bool = false
    @State private var isReading: Bool = false
    @State private var isLoading: Bool = false
   
    
    //var info: CollectionResponse.mangaCollection
    @StateObject var queuedManga: Manga
    
    //let id, title, author, artist, cover, status, synopsis: String
    
    
    @State var Chapter: [Chapter]
    
    
    
    var body: some View
    {
        //let Y = queuedManga.chapters?.firstObject as! Chapter
        //let Argus: [String] = [id, title, author, artist, cover, status, synopsis]
        
        //return X
        Divider() // Second Divider
        //HStack
        //{
            //Button(action: {isAdding.toggle()} ) {Label("Add to Library", systemImage: "folder.badge.plus").padding()}
               // .sheet(isPresented: $isAdding){ AddView(queuedManga: queuedManga) }
            
            Button("Add to Library")
            {
                isAdding.toggle()
            }
            .buttonStyle(RoundedRectangleButtonStyle())
            .sheet(isPresented: $isAdding){ AddView(queuedManga: queuedManga) }
           
        //}
        
        if !Chapter.isEmpty
        {
            BigButton(FirstChapter: Chapter.first!, LatestChapter: Chapter.last!)
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

struct RoundedRectangleButtonStyle: ButtonStyle
{
    @EnvironmentObject private var themeManager: ThemeManager
    func makeBody(configuration: Configuration) -> some View
    {
        HStack
        {
          Spacer()
            configuration.label
                .foregroundColor(themeManager.selectedTheme.label)
                .lineLimit(3)
                .multilineTextAlignment(.center)
          Spacer()
        }
        .padding()
        .background(themeManager.selectedTheme.accent.cornerRadius(8))
        .scaleEffect(configuration.isPressed ? 0.95 : 1)
  }
}

