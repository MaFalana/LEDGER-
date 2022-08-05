//
//  Ledger_0_1_2App.swift
//  Ledger 0.1.2
//
//  Created by Malik Falana on 5/30/22.
//

import SwiftUI

@main
struct LEDGERºApp: App
{
    @StateObject var themeManager = ThemeManager.shared
    @StateObject var network = CollectionLoader.shared

    //@StateObject var crudManager = CRUDManager()
    
    @AppStorage("isDarkMode") private var isDarkMode = false
    @AppStorage("isSystem") private var isSystem = false
    
    
    
    //@StateObject var coreDM = CoreDataManager()
    //@StateObject var CATALOUGE = CollectionLoader() // one copy of collectiondata that should be passed in
    //var info: CollectionResponse.mangaCollection
    //@EnvironmentObject var network: CollectionLoader
    
    
    func getScheme(Color: String) -> ColorScheme? // Function that returns the color based on the app or system environment
    {
        if Color == "System"
        {
            return .init(.unspecified)
        }
        else
        {
            if isDarkMode == false
            {
                return .light
            }
            else
            {
                return .dark
            }
        }
    }
    
    var body: some Scene
    {
        WindowGroup
        {
            //Browse().environmentObject(network)
            TabBar()
                .task{ await network.loadCollection() }
                .preferredColorScheme(isSystem ? getScheme(Color: "System") : getScheme(Color: "App") )
                //.tint(themeManager.selectedTheme.accent)
                .environmentObject(themeManager)
                //.environmentObject(mangaManager)
                //.environmentObject(libraryManager)
                //.environmentObject(network)
                //.environmentObject(crudManager)
                //.task {crudManager.Read() }
            //.environmentObject(coreDM)//
            //ContentView()
        }
    }
    
}
