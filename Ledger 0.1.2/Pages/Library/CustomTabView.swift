//
//  Library.swift
//  Ledger 0.1.2
//
//  Created by Malik Falana on 5/31/22.
//

import SwiftUI
import Foundation
//import SlidingTabView

struct CustomTabView: View
{
    @EnvironmentObject var network: CollectionLoader
    //@EnvironmentObject var libraryManager: LibraryManager
    //@EnvironmentObject var mangaManager: MangaManager
    //@EnvironmentObject var crudManager: CRUDManager
    @State private var selectedTabIndex = 0
    //SlidingTabView(selection: $selectedTabIndex,tabs: ["First Tab", "Second Tab"])
    @State private var searchText: String = ""
    
    var body: some View
    {
        if CRUDManager.shared.tabs.isEmpty
        {
            //Text("Empty Library")
        }
        else
        {
            SlidingTabView(selection: self.$selectedTabIndex, tabs: CRUDManager.shared.tabs )
            Library(libraryData: CRUDManager.shared.activeLibraries[selectedTabIndex]).environmentObject(network)
        }
        
    }
    
}
