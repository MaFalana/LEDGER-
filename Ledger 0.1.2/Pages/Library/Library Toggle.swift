//
//  Library Toggle.swift
//  Ledger 0.1.2
//
//  Created by Malik Falana on 6/2/22.
// Toggle switch for adding manga to library
// if Toggled (On), button will be filled in and will either say "remove from library" or nothing at all

import Foundation
import SwiftUI

struct libraryToggle: View
{
    @State private var inLibrary = false

    var body: some View
    {
        Toggle("Filter", isOn: $inLibrary).toggleStyle(.button).tint(.mint)
        Toggle("Filter", isOn: $inLibrary).toggleStyle(.switch).tint(.mint)
        
        
        if inLibrary == false  // If Manga is not in Library
        {
            HStack
            {
                Label("Add to Library", systemImage: "folder.badge.plus").foregroundColor(.red).padding() // add to library button
                Spacer()
            }
        }
        
        else // If Manga in Library
        {
            HStack
            {
                Label("Remove from Library", systemImage: "folder.fill.badge.minus").foregroundColor(.red).padding() // Remove from library button
                Spacer()
            }
        }
        
    }
}


//    .contextMenu()
//    {
//        Button(action: {print("Share")} ) {Label("Start Reading", systemImage: "square.and.arrow.up")}
//        Button(action: {print("Share")} ) {Label("More Details", systemImage: "square.and.arrow.up")}
//        Button(action: {print("Share")} ) {Label("Add to Library", systemImage: "square.and.arrow.up")}
//    }
