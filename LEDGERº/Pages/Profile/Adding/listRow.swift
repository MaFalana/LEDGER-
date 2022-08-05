//
//  listRow.swift
//  Ledger 0.1.2
//
//  Created by Malik Falana on 6/9/22.
//

import SwiftUI

struct listRow: View
{
    @State var library: Lib
    //let mangaInfo: [String]
    var queuedManga: Manga
    

    @Binding var selectedItems: Set<UUID>
    //var info: [String]
   // @Binding var selectedManga: Set<String>
    @EnvironmentObject var network: CollectionLoader
    //@EnvironmentObject var crudManager: CRUDManager
    @State var showAlert: Bool = false
    
    
    var isSelected: Bool
    {
        selectedItems.contains(library.id)
    }
    
    var C: [Manga]
    {
        return Array(_immutableCocoaArray:library.data ?? [])
    }
    
    
    var body: some View
    {
        
        HStack
        {
            Text(library.name)
            Spacer()
            if isSelected || C.contains(where: { $0.id == queuedManga.id}) // Checking to see if library has a manga
            {
                Image(systemName: "checkmark")
            }
        }
        .contentShape(Rectangle())
        .onTapGesture
        {
            if isSelected //If deselected
            {
                self.selectedItems.remove(library.id)
                
                //crudManager.removeManga(Library: library, selectedManga: X)
                //Removing data from a library is updating so I need to save the library afterwards
            }
            else //If selected
            {
                self.selectedItems.insert(library.id)
                //Add manga to selected Items
                //mangaManager.saveManga(id: mangaInfo[0], title: mangaInfo[1], author: mangaInfo[2], artist: mangaInfo[3], cover: mangaInfo[4], status: mangaInfo[5], synopsis: mangaInfo[6])
                
                //libraryManager.activeLibraries[0].data.append(Manga)
                //await network.populateChapter(ID: mangaInfo[0])
                
                
                if C.contains(where: {$0.id == queuedManga.id}) //Only allows one of each manga to be added
                {
                    
                    print("\(queuedManga.title) is already in \(library.name)")
                    //CRUDManager.shared.removeManga(Library: library, selectedManga: queuedManga)
                    //library.removeFromData(queuedManga)
                    //CRUDManager.shared.Save()
                }
                else
                {
                    Task
                    {
                        await CRUDManager.shared.addManga(Library: library, Manga: queuedManga)
                        //await network.loadCollection()
                    }
                    //showAlert.toggle().alert(isPresented: $showAlert) { Alert4(Name: library.name) }
                }
    
                
            }
        
        }
    }
}


struct listRow2: View
{
    var library: Lib
    //let mangaInfo: [String]
    
    

    @Binding var selectedItems: Set<UUID>
    //var info: [String]
   // @Binding var selectedManga: Set<String>
    @EnvironmentObject var network: CollectionLoader
    //@EnvironmentObject var crudManager: CRUDManager
    @State var showAlert: Bool = false
    
    var isSelected: Bool
    {
        selectedItems.contains(library.id)
    }
    
    
    
    
    var body: some View
    {
        
        HStack
        {
            Text(library.name)
            Spacer()
            if isSelected // Checking to see if library has a manga
            {
                Image(systemName: "checkmark")
            }
        }.contentShape(Rectangle()).onTapGesture {
            if isSelected //If deselected
            {
                self.selectedItems.remove(library.id)
            }
            else //If selected
            {
                self.selectedItems.insert(library.id)
            }
            //crudManager.Save() // Save function should be called her
        }
    }
}
//I should make the call to the function to same the manga somewhere here

//All selected items should make the function call, I think it should be a toggle option
// on check add data, on uncheck remove data
