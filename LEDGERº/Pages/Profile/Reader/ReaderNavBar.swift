//
//  ReaderNavBar.swift
//  Ledger 0.1.2
//
//  Created by Malik Falana on 6/5/22.
//

import SwiftUI

struct ReaderNavBar: View
{
    let ReaderTitle: String?
    @Environment(\.presentationMode) var presentationMode
    
    
    var body: some View
    {
        Divider().navigationBarTitle(ReaderTitle ?? "Nil", displayMode: .inline).navigationBarItems(leading: Button(action: {presentationMode.wrappedValue.dismiss()}, label: {Image(systemName: "xmark.circle.fill").foregroundColor(.gray).imageScale(.large)} ), trailing: HStack{(Button(action: {}) {Image(systemName: "slider.horizontal.3").imageScale(.large)}); Button(action: {}) {Image(systemName: "square.stack.3d.up")}.imageScale(.large) } )
    }
}

struct ReaderNavBar_Previews: PreviewProvider {
    static var previews: some View {
        ReaderNavBar(ReaderTitle: "Ten")
    }
}

   
