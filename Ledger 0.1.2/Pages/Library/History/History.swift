//
//  History.swift
//  Ledger 0.1.2
//
//  Created by Malik Falana on 6/2/22.
//

import SwiftUI

struct History: View
{

    @EnvironmentObject var network: CollectionLoader
    @EnvironmentObject private var themeManager: ThemeManager
    //@EnvironmentObject var crudManager: CRUDManager
    @State var showSheet: Bool = false
    
    private var History: [Chapter]
    {
        return CRUDManager.shared.History
    }
   // init(){ UITableView.appearance().backgroundColor = .clear }
    
    var body: some View
    {
        ScrollView
        {
            
            ForEach(History.indices) // Will need to populate an array of recently read manga
            {
                i in //Sentry value
                
                Button( action: { showSheet.toggle() } )
                {
                    HistoryRow(Title: History[i].mangaTitle, Title2: History[i].title!, Num: History[i].chapterNumber!, Date: Date())
                }.fullScreenCover(isPresented: $showSheet, content: {FC(ReaderTitle: History[i].title!, ChapterID: History[i].id! , MangaID: History[i].mangaId, Pages: Int(History[i].pages), Index: i, nums: [] ).accentColor(themeManager.selectedTheme.accent).environmentObject(network)} )

                
               // Divider()
            }
        }
        .navigationTitle("History")
        .listStyle(.insetGrouped)
        .background(themeManager.selectedTheme.background)//.task{ await viewModel.fetchData() }
    }
        
        //fetchdata
}