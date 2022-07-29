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
    @State private var showAlert: Bool = false
    @State private var chosenAlert: Alert = Alert(title: Text("Alert"))
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
                                showAlert.toggle()
                                CRUDManager.shared.deleteLibrary(Library: library)
                                chosenAlert = Alert9(name: library.name)
                            }
                            label:
                            {
                                Label("Remove", systemImage: "trash")
                            }.tint(.indigo)
                            .alert(isPresented: $showAlert)
                            {
                                chosenAlert
                            }
                            
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
                    showAlert.toggle()
                    if editMode
                    {
                        let previousName = CRUDManager.shared.staticLibrary.name
                        
                        
                        if CRUDManager.shared.activeLibraries.contains(where: { $0.name == userInput })
                        {
                            
                            chosenAlert = Alert6(userInput: userInput)
                        }
                        else
                        {
                            CRUDManager.shared.updateLibrary(Library: CRUDManager.shared.staticLibrary, name: userInput)
                            let currentName = CRUDManager.shared.staticLibrary.name
                            chosenAlert = Alert7(previousName: previousName, currentName: currentName)
                            userInput = "" //reverts back to empty string
                        }
                        
                        
                    }
                    else
                    {
                        guard !userInput.isEmpty else {return} // makes sure field is not empty
                        if CRUDManager.shared.activeLibraries.contains(where: { $0.name == userInput })
                        {
                            chosenAlert = Alert6(userInput: userInput)
                        }
                        else
                        {
                            CRUDManager.shared.createLibrary(name: userInput, data: [])
                            chosenAlert = Alert8(userInput: userInput)
                            userInput = "" //reverts back to empty string
                            editMode = false
                            //crudManager.Append()
                            //crudManager.Save()
                        }
                    }
                    
                }.accentColor(themeManager.selectedTheme.label).buttonStyle(.bordered)
                .alert(isPresented: $showAlert)
                {
                    chosenAlert
                }
            }.navigationBarTitle("Collections", displayMode: .inline)
        }
        
    }
}


struct AddView2: View
{
    @State var userInput: String = ""
    @State private var editMode: Bool = CRUDManager.shared.editMode
    @State private var showAlert: Bool = false
    @State private var chosenAlert: Alert = Alert(title: Text("Alert"))
    
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
                                showAlert.toggle()
                                CRUDManager.shared.deleteLibrary(Library: library)
                                chosenAlert = Alert9(name: library.name)
                            }
                            label:
                            {
                                Label("Remove", systemImage: "trash")
                            }.tint(.indigo)
                            .alert(isPresented: $showAlert)
                            {
                                chosenAlert
                            }
                            
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
                    showAlert.toggle()
                    if editMode
                    {
                        let previousName = CRUDManager.shared.staticLibrary.name

                        if CRUDManager.shared.activeLibraries.contains(where: { $0.name == userInput })
                        {
                            chosenAlert = Alert6(userInput: userInput)
                        }
                        else
                        {
                            CRUDManager.shared.updateLibrary(Library: CRUDManager.shared.staticLibrary, name: userInput)
                            let currentName = CRUDManager.shared.staticLibrary.name
                            chosenAlert = Alert7(previousName: previousName, currentName: currentName)
                            userInput = "" //reverts back to empty string
                        }
                    }
                    else
                    {
                        guard !userInput.isEmpty else {return} // makes sure field is not empty
                        if CRUDManager.shared.activeLibraries.contains(where: { $0.name == userInput })
                        {
                            chosenAlert = Alert6(userInput: userInput)
                        }
                        else
                        {
                            CRUDManager.shared.createLibrary(name: userInput, data: [])
                            chosenAlert = Alert8(userInput: userInput)
                            userInput = "" //reverts back to empty string
                            editMode = false
                            //crudManager.Append()
                            //crudManager.Save()
                        }
                    }
                    
                }.accentColor(themeManager.selectedTheme.label).buttonStyle(.bordered)//.padding()
                .alert(isPresented: $showAlert)
                {
                    chosenAlert
                }
                
            }.navigationBarTitle("Collections", displayMode: .inline)
        }
        
    }
}
