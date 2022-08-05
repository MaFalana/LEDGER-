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
    @State private var selectedTabIndex = 0
    
    //@State private var searchText: String = ""
    
    var body: some View
    {
        if !CRUDManager.shared.tabs.isEmpty
        {
            var selectedLibrary = CRUDManager.shared.activeLibraries[selectedTabIndex]
            var selectedData: [Manga] = Array(_immutableCocoaArray: selectedLibrary.data ?? [])
            
            SlidingTabView(selection: self.$selectedTabIndex, tabs: CRUDManager.shared.tabs )
            Library(libraryData: selectedLibrary, ASH: selectedData).environmentObject(network)
        }
        
    }
    
}
