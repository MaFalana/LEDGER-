//
//  WW.swift
//  Ledger 0.1.2
//
//  Created by Malik Falana on 5/31/22.
//

import Foundation
import SwiftUI

struct WW: View  //TabBar
{
    //@State var tabSelection = 1
    @State var showMenu = false
    var screenWidth = UIScreen.main.bounds.width
    
    let ReaderTitle: String?
    let ChapterID: String
    let MangaID: String
    let Pages: Range<Int> // number of pages in chapter
    
    @State private var hideNavigationBar = false
    @State private var hideStatusBar = false
    @EnvironmentObject var network: CollectionLoader
    
    
    var body: some View
    {
        TabView
        {
            NavigationView
            {
                ScrollView(.horizontal)
                {
                    HStack
                    {
                        ForEach(Pages) // number of pages
                        {
                            i in
                            //let X = try! network.quickMaths(info: info)
                            ReadView(urlString: "\(network.pageURL!)/data/\(network.pageHASH!)/\(network.pages?.chapter.data[i])")
                        }
                    }.navigationBarBackButtonHidden(true).onTapGesture(count: 1) {self.hideNavigationBar.toggle();self.hideStatusBar.toggle() }.navigationBarHidden(hideNavigationBar)
                }
            }// Tab items
                

        }.navigationTitle(ReaderTitle ?? "Nil").task { await network.fetchPage(chapterId: ChapterID) }
    }
}



