//
//  Popular.swift
//  Ledger 0.1.2
//
//  Created by Malik Falana on 6/4/22.
//

import SwiftUI

struct Recent: View
{
    @EnvironmentObject var network: CollectionLoader
    @EnvironmentObject private var themeManager: ThemeManager
    var Data: [Manga]
    {
        return network.collectionData
    }
    
    var body: some View
    {
        HStack
        {
            Text("Recently Updated").fontWeight(.bold).padding()
            Spacer()
            NavigationLink(destination: viewMore(Genre: "", Data: Data).background(themeManager.selectedTheme.background) )
            {
                
                Text("View More")
                    .padding()
                    .foregroundColor(themeManager.selectedTheme.button)
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
                    //let X =  try! network.quickMaths(info: item)
                    VStack
                    {
                                                        
                        NavigationLink(destination: Profile(info: item)) //link to profile page
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
