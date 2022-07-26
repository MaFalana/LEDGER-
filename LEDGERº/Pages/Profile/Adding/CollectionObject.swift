//
//  CollectionObject.swift
//  Ledger 0.1.2
//
//  Created by Malik Falana on 6/9/22.
//

import Foundation

struct libraryModel: Identifiable
{
    let id = UUID()
    let name: String
    let data: [CollectionResponse.mangaCollection]
}

class userLibrary: ObservableObject, Identifiable
{
    @Published var activeLibraries = [libraryModel]()
    @Published var qq = [String]()
    internal init(id: UUID = UUID(), name: String, data: [CollectionResponse.mangaCollection])
    {
        self.id = id
        self.name = name
        self.data = data
    }
    
    var id = UUID()
    var name: String
    var data: [CollectionResponse.mangaCollection]
    
    
    func populateTabNames() throws -> [String]
    {
        for i in activeLibraries
        {
            qq.append(i.name)
        }
        print(qq)
        return qq
    }
    
    func createNewLibrary(userInput: String)
    {
        activeLibraries.append( libraryModel(name: userInput, data: []) ) //userInput is library name
    }
}

class DD: ObservableObject
{
    @Published var libraries: [libraryModel] = [libraryModel(name: "One", data: []),libraryModel(name: "Two", data: []),libraryModel(name: "Three", data: []) ]
    
    @Published var tabies: [String] = []
    
    func populate()
    {
        for i in libraries
        {
            tabies.append(i.name)
        }
        print(tabies)
    }
    
    func pp() throws -> [String]
    {
        for i in libraries
        {
            tabies.append(i.name)
        }
        print(tabies)
        return tabies
    }
}
