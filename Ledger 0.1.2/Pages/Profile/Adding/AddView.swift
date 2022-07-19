//
//  AddView.swift
//  Ledger 0.1.2
//
//  Created by Malik Falana on 6/9/22.
// Modal View where the user can add a manga to a number of selected libraries or create a new library

import SwiftUI

struct AddView: View
{
    @State var userInput: String = ""
    @State private var editMode: Bool = CRUDManager.shared.editMode
    //var DD = userLibrary(name: "", data: [])
    //var DD: LibraryDataManager
    //@EnvironmentObject var libraryManager: LibraryManager
    //@EnvironmentObject var mangaManager: MangaManager
    @EnvironmentObject private var themeManager: ThemeManager
    //@EnvironmentObject var crudManager: CRUDManager
    var queuedManga: Manga
    
    @State var selectedLibraries = Set<UUID>()
   
    var body: some View
    {
        NavigationView
        {
            VStack
            {
                List(selection: $selectedLibraries)
                {
                    ForEach(CRUDManager.shared.activeLibraries)
                    {
                        library in
                        listRow(library: library, queuedManga: queuedManga, selectedItems: $selectedLibraries)
                        .swipeActions(edge: .leading, allowsFullSwipe: false)
                        {
                            Button
                            {
                                CRUDManager.shared.deleteLibrary(Library: library)
                            }
                            label:
                            {
                                Label("Remove", systemImage: "trash")
                            }.tint(.indigo)
                            
                            Button
                            {
                                editMode.toggle()
                                CRUDManager.shared.staticLibrary = library
                            }
                            label:
                            {
                                Label("Edit", systemImage: "pencil")
                                
                            }.tint(.orange)
                        }
                    }
                    
                }
                .listStyle(.insetGrouped)//.padding()
                
                TextField("Collection Name", text: $userInput )
                .accentColor(themeManager.selectedTheme.label)
                .textFieldStyle(.roundedBorder)
                .padding()
                Button(editMode ? "Change Name" : "Create Collection")
                {
                    if editMode
                    {
                        let previousName = CRUDManager.shared.staticLibrary.name

                        if CRUDManager.shared.activeLibraries.contains(where: { $0.name == userInput })
                        {
                            print("Library named \(userInput) already exists")
                        }
                        else
                        {
                            CRUDManager.shared.updateLibrary(Library: CRUDManager.shared.staticLibrary, name: userInput)
                            let currentName = CRUDManager.shared.staticLibrary.name
                            print("Library \(previousName) is now \(currentName)")
                            userInput = "" //reverts back to empty string
                        }
                        
                        
                    }
                    else
                    {
                        guard !userInput.isEmpty else {return} // makes sure field is not empty
                        if CRUDManager.shared.activeLibraries.contains(where: { $0.name == userInput })
                        {
                            print("Library named \(userInput) already exists")
                        }
                        else
                        {
                            CRUDManager.shared.createLibrary(name: userInput, data: [])
                            userInput = "" //reverts back to empty string
                            editMode = false
                            //crudManager.Append()
                            //crudManager.Save()
                        }
                    }
                    
                }.accentColor(themeManager.selectedTheme.label).buttonStyle(.bordered)
                
            }.navigationBarTitle("Collections", displayMode: .inline)
        }
        
    }
}


struct AddView2: View
{
    @State var userInput: String = ""
    @State private var editMode: Bool = CRUDManager.shared.editMode
    
    @EnvironmentObject private var themeManager: ThemeManager
   
    
    @State var selectedLibraries = Set<UUID>()
   
    var body: some View
    {
        NavigationView
        {
            VStack
            {
                List(selection: $selectedLibraries)
                {
                    ForEach(CRUDManager.shared.activeLibraries)
                    {
                        library in
                        listRow2(library: library, selectedItems: $selectedLibraries)
                        
                        .foregroundColor(themeManager.selectedTheme.label)
                        .swipeActions(edge: .leading, allowsFullSwipe: false)
                        {
                            Button
                            {
                                CRUDManager.shared.deleteLibrary(Library: library)
                            }
                            label:
                            {
                                Label("Remove", systemImage: "trash")
                            }.tint(.indigo)
                            
                            Button
                            {
                                editMode.toggle()
                                CRUDManager.shared.staticLibrary = library
                            }
                            label:
                            {
                                Label("Edit", systemImage: "pencil")
                                
                            }.tint(.orange)
                        }
                        
                        
                    }
                    
                }.listStyle(.insetGrouped)//.padding()
                
                TextField("Collection Name", text: $userInput )
                .accentColor(themeManager.selectedTheme.label)
                .textFieldStyle(.roundedBorder)
                .padding()
                Button(editMode ? "Change Name" : "Create Collection")
                {
                    if editMode
                    {
                        let previousName = CRUDManager.shared.staticLibrary.name

                        if CRUDManager.shared.activeLibraries.contains(where: { $0.name == userInput })
                        {
                            print("Library named \(userInput) already exists")
                        }
                        else
                        {
                            CRUDManager.shared.updateLibrary(Library: CRUDManager.shared.staticLibrary, name: userInput)
                            let currentName = CRUDManager.shared.staticLibrary.name
                            print("Library \(previousName) is now \(currentName)")
                            userInput = "" //reverts back to empty string
                        }
                        
                        
                    }
                    else
                    {
                        guard !userInput.isEmpty else {return} // makes sure field is not empty
                        if CRUDManager.shared.activeLibraries.contains(where: { $0.name == userInput })
                        {
                            print("Library named \(userInput) already exists")
                        }
                        else
                        {
                            CRUDManager.shared.createLibrary(name: userInput, data: [])
                            userInput = "" //reverts back to empty string
                            editMode = false
                            //crudManager.Append()
                            //crudManager.Save()
                        }
                    }
                    
                }.accentColor(themeManager.selectedTheme.label).buttonStyle(.bordered)//.padding()
                
            }.navigationBarTitle("Collections", displayMode: .inline)
        }
        
    }
}
