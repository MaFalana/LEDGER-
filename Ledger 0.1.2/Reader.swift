//
//  Reader.swift
//  Ledger.0.0.2
//
//  Created by Malik Falana on 5/29/22.
//

import Foundation
import SwiftUI

struct Reader: View
{
    let ReaderTitle: String
    let ChapterID: String
    let MangaID: String
    let Pages: Int // number of pages in chapter
    //TabBar.appearance().isHidden = true
    @State private var hideNavigationBar = false
    @EnvironmentObject var network: CollectionLoader
    var body: some View
    {
        NavigationView
        {
            ScrollView(.horizontal)
            {
                HStack
                {
                    ForEach(0 ..< Pages) // number of pages
                    {
                        i in
                        ReadView(urlString: "\(network.pageURL)/data/\(network.pageHASH)/\(network.pageDATA[i])")
                    }
                    Rectangle().frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height).foregroundColor(.black).overlay(Text("No more chapters :(").foregroundColor(.white).fontWeight(.heavy))
                }.navigationBarBackButtonHidden(true).onTapGesture(count: 1) {self.hideNavigationBar.toggle()}.navigationBarHidden(hideNavigationBar)
            }            //Tab bar
        }.navigationTitle(ReaderTitle).task { await network.fetchPage(chapterId: ChapterID) }//.task{ await network.fetchPage(chapterId: ChapterID) }//.task{ await viewModel.fetchData() }.navigationBarItems(leading: Button(action: {}) {Image(systemName: "xmark.circle.fill").imageScale(.large)}, trailing: Button(action: {}) {Image(systemName: "slider.horizontal.3").imageScale(.large)} )
    }
    
    //fetchdata
    
}

