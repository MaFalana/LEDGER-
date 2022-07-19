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
    //var network = CollectionLoader.shared
    @EnvironmentObject var network: CollectionLoader
    @EnvironmentObject private var themeManager: ThemeManager

    var body: some View
    {
        //Divider().navigationBarTitle("Ledger", displayMode: .inline).navigationBarItems(leading: (Button(action: {}) {Image(systemName: "line.3.horizontal").imageScale(.large)}))
        NavigationView
        {
            ScrollView
            {
                viewData(Data: network.collectionData, Genre: "").environmentObject(network)
                
                viewData(Data: network.shounenData, Genre: "Shounen").environmentObject(network)
                
                viewData(Data: network.shoujoData, Genre: "Shoujo").environmentObject(network)
                
                viewData(Data: network.joseiData, Genre: "Josei").environmentObject(network)
                
                viewData(Data: network.seinenData, Genre: "Seinen").environmentObject(network)
            }
            .navigationBarTitle("Ledger")
            .navigationBarTitleDisplayMode(.inline)
            .background(themeManager.selectedTheme.background)
        }
        
    }
}
