//
//  Browse.swift
//  Ledger.0.0.2
//
//  Created by Malik Falana on 5/30/22.
//

import Foundation
import SwiftUI

struct Browse: View
{
    @EnvironmentObject var network: CollectionLoader
    @EnvironmentObject private var themeManager: ThemeManager

    var body: some View
    {
        //Divider().navigationBarTitle("Ledger", displayMode: .inline).navigationBarItems(leading: (Button(action: {}) {Image(systemName: "line.3.horizontal").imageScale(.large)}))
        NavigationView
        {
            ScrollView
            {
                
                Recent().environmentObject(network)
                
                Shounen().environmentObject(network)
                
                Shoujo().environmentObject(network)
                
                Josei().environmentObject(network)
                
                Seinen().environmentObject(network)
                
            }
            //.navigationBarTitle("MangaDex")//.task{ network.chapters.removeAll()  }
            .background(themeManager.selectedTheme.background)
        }
        
    }
}
