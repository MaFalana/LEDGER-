//
//  ChapterRow.swift
//  Ledger 0.1.2
//
//  Created by Malik Falana on 6/21/22.
//

import SwiftUI

struct ChapterRow: View
{
    @EnvironmentObject var themeManager: ThemeManager
    let Title: String
    let Chapter: String
    let Date: Date//,format: .dateTime.month().day().year()
    
    var body: some View
    {
        let Accent = themeManager.selectedTheme.accent
        
        HStack
        {
            if Title == ""
            {
                Text("Chapter \(Chapter)").padding().foregroundColor(.gray).font(.caption2).lineLimit(1)
            }
            else
            {
                Text("Chapter \(Chapter): \(Title)").padding().foregroundColor(.gray).font(.caption2).lineLimit(1)
                
            }
            Spacer()
            Text("\(Date,format: .dateTime.month().day().year())").foregroundColor(.gray).font(.caption2).padding() //Date chapter was added
        }
            
        .swipeActions{
            Button { print("Muting conversation") }
            label:
            {
                Label("Download", systemImage: "square.and.arrow.down")
            }//.tint(themeManager.selectedTheme.accent)
        }
        
        
    }
}


