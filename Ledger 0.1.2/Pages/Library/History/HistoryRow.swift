//
//  HistoryRow.swift
//  Ledger 0.1.2
//
//  Created by Malik Falana on 6/26/22.
//

import SwiftUI

struct HistoryRow: View
{
    @EnvironmentObject var themeManager: ThemeManager
    let Title: String // Manga title
    let Title2: String // Chapter title
    let Num: String // Chapter Number
    let Date: Date // Date read/ added to array
    

    var body: some View
    {
        VStack
        {
            HStack
            {
                Text(Title).padding()
                Spacer()
            }

            HStack
            {
                if Title2 == ""
                {
                    Text("Chapter \(Num)").font(.caption).padding()
                }
                else
                {
                    Text("Chapter \(Num): \(Title2)").font(.caption).lineLimit(1).padding()
                }
                Spacer()
                Text(Date,format: .dateTime.month().day().year()).font(.caption2).padding()
            }.foregroundColor(.gray)
        }.foregroundColor(themeManager.selectedTheme.label)
    }
}


