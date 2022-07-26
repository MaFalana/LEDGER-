//
//  searchList.swift
//  Ledger 0.1.2
//
//  Created by Malik Falana on 6/7/22.
//

import Foundation
import SwiftUI

struct searchRow: View
{
    @EnvironmentObject private var themeManager: ThemeManager
    @EnvironmentObject var network: CollectionLoader
    let info: Manga
    //var Manga: CollectionLoader
    
    var Title: String
    {
        return info.title
    }
    var Cover: String
    {
        
//        let X = try! network.quickMaths(info: info)
//        return "https://uploads.mangadex.org/covers/\(info.id)/\(info.relationships[X].attributes!.fileName ?? "")"
        return info.cover!
    }
    
    //let Manga: CollectionResponse.mangaCollection
    
    var body: some View
    {
        HStack
        {
            SearchView(urlString: Cover).cornerRadius(10)//Cover Art
            Text(Title).foregroundColor(themeManager.selectedTheme.label).lineLimit(1) //Title
            Spacer()
        }
    }
}
