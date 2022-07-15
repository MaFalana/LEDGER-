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
        return info.chapters?.count ?? 0
    }
    


    var body: some View
    {
        
        ScrollView(.vertical)
        {
            InfoView(Title: Title, Author: Author, Artist: Artist, Cover: Cover, Status: Status, Count: Count) //View for basic info of Manga
            
            ButtonView(queuedManga: info).environmentObject(network)//.environmentObject(coreDM) // View for various buttons
            
            DescriptionView(Synopsis: Description) // View for Manga Description/Synopsis
            
            TagView(queuedManga: info) // View for Genre Tags
            
            ChapterListView(quequedManga: info).environmentObject(network) // List View of aviliable Chapters
            
        }
            
            
    
        
        .background(themeManager.selectedTheme.background)
        .navigationBarTitle(Text(Title))
        .navigationBarTitleDisplayMode(.inline)

    }
    
        
}




