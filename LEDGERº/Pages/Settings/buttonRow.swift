//
//  buttonRow.swift
//  Ledger 0.1.2
//
//  Created by Malik Falana on 6/13/22.
//

import SwiftUI

struct buttonRow: View
{
    let Name: String
    let Value: Int
    @Binding var selectedItem: String
    @EnvironmentObject private var themeManager: ThemeManager
   
    
    var body: some View
    {
        HStack
        {
            Text(Name)
            Spacer()
            if Name == selectedItem
            {
                Image(systemName: "checkmark").foregroundColor(themeManager.selectedTheme.accent)
            }
        }.contentShape(Rectangle()).onTapGesture
        {
            self.selectedItem = self.Name ; withAnimation{ themeManager.updateTheme(Value) }
        }.task { self.selectedItem = themeManager.selectedTheme.themeName }
    }
}

