//
//  History.swift
//  Ledger 0.1.2
//
//  Created by Malik Falana on 6/2/22.
//

import SwiftUI

struct HistoryView: View
{

    //@EnvironmentObject var network: CollectionLoader
    @EnvironmentObject private var themeManager: ThemeManager
    //@EnvironmentObject var crudManager: CRUDManager
    //@State private var showSheet = false
    
    private var History: [History]
    {
        return CRUDManager.shared.Hist.sorted{ $0.readDate! > $1.readDate! } 
    }
    
    var body: some View
    {
        ZStack
        {
            themeManager.selectedTheme.background.ignoresSafeArea(.all)
            List(History) // Will need to populate an array of recently read manga
            {
                i in //Sentry value
                HistoryRow(i:i)

               // Divider()
            }.listStyle(.insetGrouped)
        }
        .background(themeManager.selectedTheme.background)
        .task
        {
            for i in History
            {
                print(i.chapter!.source?.title)
            }
        }
        .navigationTitle("History")
        .navigationBarTitleDisplayMode(.large)
        //.listStyle(.insetGrouped)
        //.task{ await viewModel.fetchData() }
    }
        
        //fetchdata
}
