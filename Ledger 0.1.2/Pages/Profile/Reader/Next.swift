//
//  Next.swift
//  Ledger 0.1.2
//
//  Created by Malik Falana on 6/8/22.
//

import SwiftUI

struct Next: View
{
    @EnvironmentObject var network: CollectionLoader
    let Index: Int
    let MangaID: String
    
    var body: some View
    {
        var newIndex: Int = Index + 1
        
        //nextChapter(Index: Index)
        
        
        FC(ReaderTitle: network.chapters[newIndex].attributes.title ?? "", ChapterID: network.chapters[newIndex].id , MangaID: MangaID, Pages: network.chapters[newIndex].attributes.pages, Index: newIndex, nums: [] ).environmentObject(network)
    }
    
    func nextChapter(Index: Int)
    {
        // Current Index is Passed in
        
        //One is added to current Index
        
        //Next Chapter

        let newIndex = Index + 1
        
        if Index == 0
        {
            firstChapter(newIndex: newIndex).environmentObject(network)
        }
        else if Index != 0
        {
            newChapter(currentIndex: Index, newIndex: newIndex).environmentObject(network)
            print("Index is \(newIndex)")
        }
    }
}


struct firstChapter: View
{
    let newIndex: Int
    @EnvironmentObject var network: CollectionLoader
    
    var body: some View
    {
        VStack
        {
            Text("Previous: ").padding()
            //Spacer()
            Text("Next: \(network.chapters[newIndex].attributes.title ?? "")")
        }
    }
}

struct newChapter: View
{
    let currentIndex: Int
    let newIndex: Int
    @EnvironmentObject var network: CollectionLoader
    
    var body: some View
    {
        VStack
        {
            Text("Previous: \(network.chapters[currentIndex].attributes.title ?? "")").padding()
            //Spacer()
            Text("Next: \(network.chapters[newIndex].attributes.title ?? "")")
        }
    }
}
