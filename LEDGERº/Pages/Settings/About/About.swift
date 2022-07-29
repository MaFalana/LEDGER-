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
                Text("1.1.2").foregroundColor(.gray)
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
    var body: some View
    {
        List
        {
            HStack
            {
                Text("Version")
                Spacer()
                Text("0.1.2").foregroundColor(.gray)
            }
            
        }.navigationBarTitle("Backups")
    }
}
