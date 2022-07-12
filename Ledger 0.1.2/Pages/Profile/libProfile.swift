////
//  ProfileView.swift
//  Ledger.0.0.2
//
//  Created by Malik Falana on 5/29/22.
//

import Foundation
import SwiftUI

struct libProfile: View // Profile for Manga
{
    @EnvironmentObject var network: CollectionLoader
    @EnvironmentObject private var themeManager: ThemeManager
    @EnvironmentObject var crudManager: CRUDManager
    //@EnvironmentObject var coreDM: CoreDataManager

    @State var queuedManga: Manga
    
    private var Title: String
    {
        return queuedManga.title ?? ""
    }
    private var Author: Author
    {
        return queuedManga.author!
    }
    private var Artist: Artist
    {
        return queuedManga.artist!
    }
    private var Cover: String
    {
        return queuedManga.cover ?? ""
    }
    private var Status: String
    {
        return queuedManga.status ?? ""
    }
    private var Description: String
    {
        return queuedManga.synopsis ?? ""
    }
    private var ID: String
    {
        return queuedManga.id ?? ""
    }
    private var Count: Int
    {
        //return queuedManga.chapters?.count ?? 0
        return 0
    }
    
    private var tagCount: Int
    {
        return 0
        
    }
    private var chapters: [Chapter]
    {
        //return (lib.chapters) as! [Chapter]
        return Array(_immutableCocoaArray: queuedManga.chapters ?? [] )
        //return []
    }

    var body: some View
    {

        ScrollView
        {
            //InfoView(Title: lib.title!, Status: lib.status).environmentObject(coreDM) //View for basic info of Manga
            InfoView(Title: Title, Author: Author, Artist: Artist, Cover: Cover, Status: Status, Count: Count)//.environmentObject(coreDM)

            //ButtonView(queuedManga: queuedManga)//.environmentObject(network)//.environmentObject(coreDM) // View for various buttons

            DescriptionView(Synopsis: Description) // View for Manga Description/Synopsis

            TagView(queuedManga: queuedManga) // View for Genre Tags

            libChapterListView(ID: ID, ChapterList: chapters)//.environmentObject(network) // List View of aviliable Chapters

        }
        .background(themeManager.selectedTheme.background)
        .navigationBarTitle(Title)
        .navigationBarTitleDisplayMode(.inline)//.task{ await network.populateChapter(ID: ID) }
//        .task
//        {
//            crudManager.quequedManga = queuedManga
//        }
    }


}




