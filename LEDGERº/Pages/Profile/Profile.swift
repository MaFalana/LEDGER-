//
//  ProfileView.swift
//  Ledger.0.0.2
//
//  Created by Malik Falana on 5/29/22.
//

import Foundation
import SwiftUI

struct Profile: View // Profile for Manga
{
    @EnvironmentObject var network: CollectionLoader
    @EnvironmentObject var crudManager: CRUDManager
    @EnvironmentObject private var themeManager: ThemeManager
    @State private var showAlert = false
    @StateObject var info: Manga
    
    
    private var Title: String
    {
        return info.title
    }
    private var Author: Author
    {
        return info.author!
    }
    private var Artist: Artist
    {
        return info.artist!
    }
    private var Cover: String
    {
        return info.cover!
    }
    private var Status: String
    {
        return info.status!
    }
    private var Description: String
    {
        return info.synopsis!
    }
    private var ID: String
    {
        return info.id
    }
    private var Count: Int
    {
        let x = Array(info.chapters ?? [])
        return x.count
    }
    private var Chapter: [Chapter]
    {
        return Array(_immutableCocoaArray: info.chapters ?? [] ).sorted{Float($0.chapterNumber!)! < Float($1.chapterNumber!)!}
    }
    


    var body: some View
    {
        
        ScrollView(.vertical , showsIndicators: false)
        {
            InfoView(Title: Title, Author: Author, Artist: Artist, Cover: Cover, Status: Status, Count: Count) //View for basic info of Manga
            
            ButtonView(queuedManga: info, Chapter: Chapter).environmentObject(network)//.environmentObject(coreDM) // View for various buttons
            
            DescriptionView(Synopsis: Description) // View for Manga Description/Synopsis
            
            TagView(queuedManga: info) // View for Genre Tags
            
            if Count == 0
            {
                
            }
            else
            {
                ChapterListView(quequedManga: info).environmentObject(network) // List View of aviliable Chapters
            }
            
        }
        .background(themeManager.selectedTheme.background)
        .navigationBarTitle(Text(Title))
        .navigationBarTitleDisplayMode(.inline)
        .toolbar
        {
            ToolbarItem(placement: .navigationBarTrailing)
            {
                Menu
                {
                    Button("Check for Updates") { showAlert.toggle();Task{await CRUDManager.shared.updateManga(Manga: info)} }
                    .alert(isPresented: $showAlert)
                    {
                        Alert5()
                    }
                    //Button("4 Items") { rowItems = 4 }
                    //Button("5 Items") { rowItems = 5 }
                }
                label:
                {
                    Image(systemName: "ellipsis").imageScale(.large)
                }
            }
            
        }
        .task
        {
            if Count == 0
            {
                await CRUDManager.shared.updateManga(Manga: info)
                
            }
            
            
        }

    }
    
        
}




