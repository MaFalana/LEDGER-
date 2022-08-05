//
//  About.swift
//  Ledger 0.1.2
//
//  Created by Malik Falana on 6/13/22.
//

import SwiftUI

struct About: View
{
    var body: some View
    {
        List
        {
            HStack
            {
                Text("Version")
                Spacer()
                Text("1.1.3").foregroundColor(.gray)
            }
            
        }.navigationBarTitle("About")
    }
}

struct About_Previews: PreviewProvider {
    static var previews: some View {
        About()
    }
}


struct Backups: View
{
    @State private var showAlert = false
    @State private var chosenAlert: Alert = Alert(title: Text("Alert"))
    
    var Backups: [Backup]
    {
        //return Array(_immutableCocoaArray: CRUDManager.shared.Back ?? [] )
        return CRUDManager.shared.Back ?? []
    }
    
    var body: some View
    {
        List(Backups)
        {
            i in
            Button(action: { showAlert.toggle(); chosenAlert = AlertXIII(Backup: i) } )
            {
                BackupRow(Backup: i)
            }
            .swipeActions(edge: .leading, allowsFullSwipe: false)
            {
                Button(
                    action:
                    {
                        showAlert.toggle()
                        print("Delete Backup")
                        chosenAlert = AlertXI(Backup: i)
                    } )
                {
                    Label("Delete", systemImage: "trash")
                    
                }.tint(.indigo)
                
                
                Button(
                    action:
                    {
                        showAlert.toggle()
                        print("Share Backup")
                        chosenAlert = AlertXII() //will probally have to pass in specific backup
                    } )
                {
                    Label("Share", systemImage: "square.and.arrow.up")
                    
                }.tint(.blue)
                
                
                
            }
            
        }
        .navigationBarTitle("Backups")
        .refreshable
        {
            CRUDManager.shared.createBackup()
        }
        .alert(isPresented: $showAlert)
        {
            chosenAlert
        }
    }
}


struct BackupRow: View
{
    @EnvironmentObject var themeManager: ThemeManager
    let Backup: Backup
    
    var Name: String
    {
        return Backup.id?.description ?? ""
    }

    var Date: Date
    {
        return Backup.creationDate ?? Foundation.Date()
    }
    
    //,format: .dateTime.month().day().year()
 
    var body: some View
    {
        
        HStack
        {
            Text(Name).lineLimit(1).font(.caption)
            Spacer()
            Text(Date,format: .dateTime.month().day().year()).foregroundColor(.gray).font(.caption2)
            Text(Date,style: .time).font(.caption2).foregroundColor(.gray)
        }

    }
}
