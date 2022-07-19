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
        ZStack
        {
            themeManager.selectedTheme.background.ignoresSafeArea(.all)
            List(History) // Will need to populate an array of recently read manga
            {
                i in //Sentry value
                
                Button( action: { showSheet.toggle() } )
                {
                    HistoryRow(Title: i.source!.title, Title2: i.title!, Num: i.chapterNumber!, Date: Date())
                }.fullScreenCover(isPresented: $showSheet, content: {FC(Chapter: i, Pages: Int(i.pages)).accentColor(themeManager.selectedTheme.accent).environmentObject(network)} )

                
               // Divider()
            }
        }
        .background(themeManager.selectedTheme.background)
        .task
        {
            for i in History
            {
                print("\(i)")
            }
        }
        .navigationTitle("History")
        //.listStyle(.insetGrouped)
        //.task{ await viewModel.fetchData() }
    }
        
        //fetchdata
}
