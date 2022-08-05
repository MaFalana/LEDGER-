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
    
    var network = CollectionLoader.shared
    
    @State var tabSelection = 1
    @State var showMenu = false
    
    
    
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
//                            Image(systemName: "magnifyingglass").imageScale(.large).foregroundColor(themeManager.selectedTheme.accent)
                            
//                            Button(action: {CRUDManager.shared.isHidden.toggle()} )
//                            {
//                                Label("Search", systemImage: "magnifyingglass")
//                                .labelStyle(.iconOnly)
//                                .imageScale(.large)
//                                
//                            }
                            
                            Menu
                            {
                                Button("3 Items") { CRUDManager.shared.rowItems = 3 }
                                Button("4 Items") { CRUDManager.shared.rowItems = 4 }
                                Button("5 Items") { CRUDManager.shared.rowItems = 5 }
                            }
                            label:
                            {
                                Image(systemName: "square.stack.3d.up").imageScale(.large)
                            }
                           
            
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
                            NavigationLink(destination: HistoryView() )
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
        //.task{ await network.loadCollection() }
        //; for i in network.collectionData { await network.fetchDetails(mangaId: i.id) } }
    }
    //.navigationTitle("Swift").toolbar{Image(systemName: "rectangle.grid.3")}
}
