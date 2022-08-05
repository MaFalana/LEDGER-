//
//  SwiftUIView.swift
//  Ledger 0.1.2
//
//  Created by Malik Falana on 6/26/22.
//

import SwiftUI



func Alert1() -> Alert
{
    return Alert(title: Text("This action will clear all app data"), message: Text("Do you still want to proceed?") , primaryButton: .destructive(Text("Yes")) { CRUDManager.shared.Reset() }, secondaryButton: .cancel() )
}

func Alert2() -> Alert
{
    return Alert(title: Text("This action will delete all reading history"), message: Text("Do you still want to proceed?") , primaryButton: .destructive(Text("Yes")) { CRUDManager.shared.deleteHistory() }, secondaryButton: .cancel() )
}

func Alert3() -> Alert
{
    return Alert(title: Text("Alert"), message: Text("This action will clear all app data") )
}

func Alert4(Name: String) -> Alert
{
    return Alert(title: Text("Alert"), message: Text("Manga Already in \(Name)") )
}


func Alert5() -> Alert
{
    //let Total = CRUDManager.shared.Total
    let Response = CRUDManager.shared.Response
    return Alert(title: Text(Response) )
}

func Alert6(userInput: String) -> Alert
{
    return Alert(title: Text("\(userInput) already exists") )
}

func Alert7(previousName: String, currentName: String ) -> Alert
{
    return Alert(title: Text("Library \(previousName) is now \(currentName)") )
}

func Alert8(userInput: String) -> Alert
{
    return Alert(title: Text("Library \(userInput) successfully created") )
}

func Alert9(name: String) -> Alert
{
    return Alert(title: Text("Library \(name) and its contents were successfully deleted") )
}

func Alert10(name: String, library: String) -> Alert
{
    return Alert(title: Text("\(name) was successfully removed from \(library)") )
}

func AlertXI(Backup: Backup) -> Alert // Delete Backup Alert
{
    return Alert(title: Text("Are you sure you want to delete this backup?"), primaryButton: .destructive(Text("Delete")) { CRUDManager.shared.deleteBackup(selectedBackup: Backup) }, secondaryButton: .cancel() )
}

func AlertXII() -> Alert  // Share Backup Alert
{
    return Alert(title: Text("Backup shared") )
}

func AlertXIII(Backup: Backup) -> Alert // Load from Backup Alert
{
    return Alert(title: Text("Would you like to load from this backup"), primaryButton: .destructive(Text("Yes")) { CRUDManager.shared.loadBackup(selectedBackup: Backup) }, secondaryButton: .cancel() )
}
