//
//  Josei.swift
//  Ledger 0.1.2
//
//  Created by Malik Falana on 6/4/22.
//

import SwiftUI

struct Josei: View
{
    @EnvironmentObject var network: CollectionLoader
    @EnvironmentObject private var themeManager: ThemeManager
    var Data: [Manga]
    {
        return network.joseiData
    }
    
    var body: some View
    {
        HStack
        {
            Text("Josei").fontWeight(.bold).padding()
            Spacer()
            NavigationLink(destination: viewMore(Genre: "Josei", Data: Data).background(themeManager.selectedTheme.background).environmentObject(network) )
            {
                
                Text("View More").padding()
                //Image(systemName: "chevron.right").padding().foregroundColor(.theme.accent)
            }
        }
        ScrollView(.horizontal)
        {
            HStack//LazyHGrid(rows: [GridItem(.adaptive(minimum: 90), spacing: 8)],spacing: 12)
            {
                ForEach( Data.prefix(20) )
                {
                    item in
                    
                    VStack
                    {
                                                        
                        NavigationLink(destination: Profile(info: item).environmentObject(network)) //link to profile page
                        {
                            BrowseView(urlString: item.cover!).cornerRadius(10)
                        }
                        Text(item.title).bold().frame(width: 120).lineLimit(1)
                    }
                
                }
                // A view all button could go here
            }.padding()
        }
    }
}
