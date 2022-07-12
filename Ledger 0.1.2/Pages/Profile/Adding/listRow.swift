//
//  listRow.swift
//  Ledger 0.1.2
//
//  Created by Malik Falana on 6/9/22.
//

import SwiftUI

struct listRow: View
{
    var library: Lib
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
    
    
    
    
    var body: some View
    {
        
        HStack
        {
            Text(library.name)
            Spacer()
            if isSelected || library.data!.contains(queuedManga) // Checking to see if library has a manga
            {
                Image(systemName: "checkmark")
            }
        }.contentShape(Rectangle()).onTapGesture {
            if isSelected //If deselected
            {
                self.selectedItems.remove(library.id)
                //CRUDManager.shared.removeManga(Library: library, Id: mangaInfo[0])
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
                
                
                if ((library.data?.contains(queuedManga)) != nil) //Only allows one of each manga to be added
                {
                    Task
                    {
                        await CRUDManager.shared.addManga(Library: library, Manga: queuedManga)
                        //await network.loadCollection()
                    }
                    
                }
                else
                {
                    print("\(queuedManga.title) is already in \(library.name)")
                    //showAlert.toggle().alert(isPresented: $showAlert) { Alert4(Name: library.name) }
                }
                
                
                /*Task
                {
                    let X = try! await mangaManager.createManga(id: mangaInfo[0], title: mangaInfo[1], author: mangaInfo[2], artist: mangaInfo[3], cover: mangaInfo[4], status: mangaInfo[5], synopsis: mangaInfo[6])
                 
                    
                    library.data?.append(X)
                    
                    //crudManager.Create()
                    //libraryManager.Save()
                }*/
                
            }
            //crudManager.Save() // Save function should be called her
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
