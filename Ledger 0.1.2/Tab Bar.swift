//
//  Tab Bar.swift
//  Ledger 0.1.2
//
//  Created by Malik Falana on 5/31/22.
//

import Foundation
import SwiftUI
struct TabBar: View  //TabBar
{
    @EnvironmentObject private var themeManager: ThemeManager
    //@EnvironmentObject private var crudManager: CRUDManager
    //@EnvironmentObject private var  libraryManager: LibraryManager
    var network = CollectionLoader()
    //var ss = DD()
    //@EnvironmentObject var coreDM: CoreDataManager
    //var coreDM = CoreDataManager()
    //var info: CollectionResponse.mangaCollection
    
    @State var tabSelection = 1
    @State var showMenu = false
    //var screenWidth = UIScreen.main.bounds.width
    
   // init(){ UITableView.appearance().backgroundColor = .clear }
    
    
    var body: some View
    {
        TabView(selection: $tabSelection)
        {
            
            Browse().tabItem {Image(systemName: "square.grid.2x2");Text("Browse") }.tag(1)
             
            
            
            
            /*Search().tabItem
            {
                Image(systemName: "magnifyingglass");Text("Search")
                
            }.tag(2)
             */
             
            NavigationView
             {
                     Search().environmentObject(network)
             }.tabItem{Image(systemName: "magnifyingglass");Text("Search")}.tag(2)
             
             
             
            
            NavigationView
            {
                ScrollView
                {
                    CustomTabView()//.environmentObject(coreDM)
                        //.environmentObject(libraryManager)
                    
                }.background(themeManager.selectedTheme.background)
                    .navigationBarTitle("Library", displayMode: .inline)
                    .toolbar{
                        ToolbarItemGroup(placement: .navigationBarTrailing)
                        {
                            Image(systemName: "magnifyingglass").imageScale(.large).foregroundColor(themeManager.selectedTheme.accent)
                           
            
                            Button(action: {showMenu.toggle()} )
                            {
                                Label("Add Library", systemImage: "plus")
                                .labelStyle(.iconOnly)
                                .imageScale(.large)
                                .sheet(isPresented: $showMenu){ AddView2() }
                                
                            }

                        }
                        
                        ToolbarItemGroup(placement: .navigationBarLeading)
                        {
                            NavigationLink(destination: History() )
                            {
                                Image(systemName: "clock.arrow.circlepath").foregroundColor(Color.yellow).imageScale(.large)
                                
                            }
                        }
                    }
                    
                    
            }.tabItem{Image(systemName: "books.vertical.fill");Text("Library")}.tag(3)
            
           /* NavigationView
            {
                ScrollView
                {
                    Radio()
                }
            }.tabItem{Image(systemName: "play.fill");Text("Radio")}.tag(4)
            */
            
            NavigationView
            {
                
                Settings().tint(themeManager.selectedTheme.accent).navigationBarTitle("Settings")
                
                
            }.tabItem{Image(systemName: "gear");Text("Settings")}.tag(4)
            
            
        

        }
        .environmentObject(network)
        .accentColor(themeManager.selectedTheme.button)
         .task{ await network.loadCollection() }
        //; for i in network.collectionData { await network.fetchDetails(mangaId: i.id) } }
    }
    //.navigationTitle("Swift").toolbar{Image(systemName: "rectangle.grid.3")}
}
