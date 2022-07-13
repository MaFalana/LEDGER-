//
//  viewData.swift
//  Ledger 0.1.2
//
//  Created by Malik Falana on 7/13/22.
//

import Foundation
import SwiftUI

struct viewData: View
{
    @EnvironmentObject var network: CollectionLoader
    @EnvironmentObject private var themeManager: ThemeManager
    var Data: [Manga]
    var Genre: String
    var Title: String
    {
        if Genre == ""
        {
           return "Recently Updated"
        }
        else
        {
            return Genre
        }
        
    }
    
    var body: some View
    {
        HStack
        {
            Text(Title).fontWeight(.bold).padding()
            Spacer()
            NavigationLink(destination: viewMore(Genre: Genre, Data: Data).background(themeManager.selectedTheme.background).environmentObject(network) )
            {
                
                Text("View More").padding()
                //Image(systemName: "chevron.right").padding().foregroundColor(.theme.accent)
            }
        }
        ScrollView(.horizontal)
        {
            HStack//LazyHGrid(rows: [GridItem(.adaptive(minimum: 90), spacing: 8)],spacing: 12)
            {
                ForEach(Data.prefix(20), id: \.id)
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
