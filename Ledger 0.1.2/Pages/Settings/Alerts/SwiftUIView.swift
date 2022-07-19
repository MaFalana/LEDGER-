//
//  SwiftUIView.swift
//  Ledger 0.1.2
//
//  Created by Malik Falana on 6/26/22.
//

import SwiftUI



func Alert1() -> Alert
{
    return Alert(title: Text("Alert"), message: Text("This action will clear all app data") )
}

func Alert2() -> Alert
{
    return Alert(title: Text("Alert"), message: Text("This action will delete all reading history") )
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
