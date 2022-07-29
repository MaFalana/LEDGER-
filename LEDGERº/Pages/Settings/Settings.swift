//
//  Settings.swift
//  Ledger 0.1.2
//
//  Created by Malik Falana on 6/12/22.
//

import SwiftUI

struct Settings: View
{
    @State var appToggle: Bool = false
    @State var systemToggle: Bool = false
    @State private var showAlert: Bool = false
    @EnvironmentObject private var themeManager: ThemeManager
    //@EnvironmentObject private var crud: CRUDManager
    @AppStorage("isDarkMode") private var isDarkMode = false
    @AppStorage("isSystem") private var isSystem = false
    //@AppStorage("isSyncing") private var isSyncing = CRUDManager.shared.isSyncing
    init(){ UITableView.appearance().backgroundColor = .clear }
    @State var selectedItem: String = ""
    
    
    
    var body: some View
    {
        List
        {
            Section("About")
            {
                NavigationLink(destination: About().background(themeManager.selectedTheme.background))
                {
                    Text("About")
                }
                Link("GitHub Repository", destination: URL(string: "https://github.com/MaFalana/Ledger.git")!).foregroundColor(themeManager.selectedTheme.accent)
                Link("Discord Server", destination: URL(string: "https://discord.gg/nZhX8Wrf")!).foregroundColor(themeManager.selectedTheme.accent)
            }
            
            Section("General")
            {
                //Toggle("iCloud Sync", isOn: $isSyncing)
//                NavigationLink(destination: Backups().background(themeManager.selectedTheme.background))
//                {
//                    Text("Backups")
//                }
                HStack
                {
                    Text("Appearance")
                    Spacer()
                    Picker("Appearance", selection: $isDarkMode)
                    {
                        Text("Light").tag(false)
                        Text("Dark").tag(true)
                    }.pickerStyle(.segmented).fixedSize().disabled(isSystem)
                }
                //Toggle("Appearance", isOn: $isDarkMode).disabled(isSystem)
                Toggle("Use System Appearance", isOn: $isSystem)
            }
            
            
            Section("Theme")
            {
                ForEach(0..<themeManager.themes.count)
                {
                    i in
                    buttonRow(Name: themeManager.themes[i].themeName, Value: i, selectedItem: $selectedItem).foregroundColor(themeManager.selectedTheme.text)
                }
            }
            
//            Section("Advanced")
//            {
//                Button("Clear Chapter Cache") {}.foregroundColor(themeManager.selectedTheme.text)
//                Button("Clear Manga Cache") {}.foregroundColor(themeManager.selectedTheme.text)
//                Button("Clear Network Cache") {}.foregroundColor(themeManager.selectedTheme.text)
//                Button("Clear Read History") {CRUDManager.shared.History.removeAll()}.foregroundColor(themeManager.selectedTheme.text)
//                Button("Reset") { showAlert.toggle() }.foregroundColor(themeManager.themes.first?.accent).alert(isPresented: $showAlert)
//                {
//                    Alert1()
//                }
//            }
            
        }.listStyle(.insetGrouped).background(themeManager.selectedTheme.background)
    }
    
}



