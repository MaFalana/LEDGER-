//
//  Tag View.swift
//  Ledger 0.1.2
//
//  Created by Malik Falana on 6/1/22.
//

import Foundation
import SwiftUI

struct TagView: View
{
    @EnvironmentObject private var themeManager: ThemeManager

    let queuedManga: Manga
    
    private var Genre: [Tag]
    {
        return Array(_immutableCocoaArray: queuedManga.tags ?? [] )
    }
    
    var body: some View
    {
        Text("Genres").fontWeight(.bold).frame(width: 415, alignment: .leading)
        
        ScrollView(.horizontal)
        {
            HStack
            {
                ForEach(Genre) // Will need to populate an array of Mangas genre types, I want there to be a max of 5 columns
                {
                    i in
                    NavigationLink(destination: viewTag(Genre: i).background(themeManager.selectedTheme.background) )
                    {
                        RoundedRectangle(cornerRadius: 25).frame(width: 130, height: 30).foregroundColor(themeManager.selectedTheme.listBack).overlay( Text(i.name!) )
                    }.foregroundColor(themeManager.selectedTheme.label)
                }
            }
        }
    }
}


//TagView(TAGS: info.attributes.tags.indices, genreTags: info.attributes.tags[i].attributes.name.en)
