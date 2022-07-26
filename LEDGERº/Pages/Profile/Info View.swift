//
//  Info View.swift
//  Ledger 0.1.2
//
//  Created by Malik Falana on 6/1/22.
//

import SwiftUI

struct InfoView: View
{
    @EnvironmentObject var themeManager: ThemeManager
    let Title: String
    let Author: Author
    let Artist: Artist
    let Cover: String
    let Status: String
    let Count: Int

    var body: some View
    {
        HStack
        {
            ProfileView(urlString: Cover)
            
            VStack
            {
                Text(Title).padding().lineLimit(1) // Manga title
                Divider() // First Divider
                NavigationLink(destination: viewAuthor(Author: Author).background(themeManager.selectedTheme.background) )
                {
                    Text("By \(Author.name!)").padding() // Manga Author
                }.foregroundColor(themeManager.selectedTheme.label)
                Text(Status).padding() // Manga Status
                NavigationLink(destination: viewArtist(Artist: Artist).background(themeManager.selectedTheme.background) )
                {
                    Text("Art by \(Artist.name!)").padding() // Manga illustrator
                }.foregroundColor(themeManager.selectedTheme.label)
                Text("\(Count) Unique Chapter(s)") // Number of chapters //add 1 because arrays start at 0
            }
            
        }
    }
}

