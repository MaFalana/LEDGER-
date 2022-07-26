//
//  Reader Menu.swift
//  Ledger 0.1.2
//
//  Created by Malik Falana on 6/16/22.
//

import SwiftUI

struct Reader_Menu: View
{
    var orient = ["Vertical", "Horizontal"]
    //@State private var selectedValue = "Horizontal"
    @State var selectedValue = CRUDManager.shared.isOrient ? "Vertical" : "Horizontal"
    
    
    var body: some View
    {
        Menu
        {
            Section("Orientation")
            {
                Picker("Orientation", selection: $selectedValue )
                {
                    ForEach(orient, id: \.self)
                    {
                        Text($0)
                    }
                }
                .onChange(of: selectedValue)
                {
                    i in
                    if i == "Vertical"
                    {
                        CRUDManager.shared.isOrient.toggle()
                    }
//                    else
//                    {
//                        CRUDManager.shared.isOrient.toggle()
//                    }
                    
                    
                }
            }//.pickerStyle(.segmented)
        }
        label:
        {
            Image(systemName: "slider.horizontal.3").imageScale(.large)
        }
    }
}



struct Sort_Menu: View
{
    @State public var rowItems: Int = 3
    
    
    var body: some View
    {
        Menu
        {
            Button("3 Items") { rowItems = 3 }
            Button("4 Items") { rowItems = 4 }
            Button("5 Items") { rowItems = 5 }
        }
        label:
        {
            Image(systemName: "square.stack.3d.up").imageScale(.large)
        }
    }
}

struct chapterSort: View
{
    @State public var rowItems: Int = 3
    //@State private var selectedValue = 0
    @AppStorage("selectedValue") private var selectedValue = 0
    
    var body: some View
    {
        Menu
        {
            Picker("Chapter Order", selection: $selectedValue )
            {
                Button("Source") { rowItems = 3 }.tag(0)
                Button("Chapter") { rowItems = 4 }.tag(1)
                //Button("5 Items") { rowItems = 5 }
            }
            .onChange(of: selectedValue)
            {
                i in
                if i == 0
                {
                    print("Source")
                }
                else
                {
                    print("Chapter")
                }
                
                
            }
        }
        label:
        {
            Image(systemName: "line.3.horizontal.decrease").imageScale(.large)
        }
    }
}
