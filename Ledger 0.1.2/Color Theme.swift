//
//  Color Theme.swift
//  Ledger 0.1.2
//
//  Created by Malik Falana on 6/10/22.
//

import Foundation
import SwiftUI


struct LaunchTheme
{
    let accent = Color("LaunchAccentColor")
    let background = Color("LaunchBackgroundColor")
}


protocol Theme
{
    var accent: Color{get set}
    var background: Color{get set}
    var label: Color{get set}
    var text: Color{get set}
    var button: Color{get set}
    var themeName: String{get set}
    
}

final class Default: Theme
{
    var button: Color = Color("AccentColor")
    
    var accent: Color = Color("AccentColor")
    
    var background: Color  = Color("BackgroundColor")
    
    var label: Color = Color("labelColor")
    
    var text: Color = Color("labelColor")
    
    var themeName: String = "Default"
}

final class Huntington: Theme
{
    var button: Color = Color("ButtonColor_Huntington")
    
    var accent: Color = Color("AccentColor_Huntington")
    
    var background: Color  = Color("BackgroundColor_Huntington")
    
    var label: Color = Color("labelColor_Huntington")
    
    var text: Color = Color("textColor_Huntington")
    
    var themeName: String = "Granny Smith"
}

final class MangaSoup: Theme
{
    var button: Color = Color("AccentColor_MangaSoup")
    
    var accent: Color = Color("AccentColor_MangaSoup")
    
    var background: Color  = Color("BackgroundColor_MangaSoup")
    
    var label: Color = Color("labelColor")
    
    var text: Color = Color("labelColor")
    
    var themeName: String = "MangaSoup"
}

final class Crunchyroll: Theme
{
    var button: Color = Color("AccentColor_Crunchyroll")
    
    var accent: Color = Color("AccentColor_Crunchyroll")
    
    var background: Color  = Color("BackgroundColor_Crunchyroll")
    
    var label: Color = Color("labelColor_Crunchyroll")
    
    var text: Color = Color("labelColor")
    
    var themeName: String = "Crunchyroll"
}

final class Funimation: Theme
{
    var button: Color = Color("AccentColor_Funimation")
    
    var accent: Color = Color("AccentColor_Funimation")
    
    var background: Color  = Color("BackgroundColor_Funimation")
    
    var label: Color = Color("labelColor")
    
    var text: Color = Color("textColor_Funimation")
    
    var themeName: String = "Funimation"
}

final class Green: Theme
{
    var button: Color = Color("AccentColor_Green")
    
    var accent: Color = Color("AccentColor_Green")
    
    var background: Color  = Color("BackgroundColor_Green")
    
    var label: Color = Color("labelColor")
    
    var text: Color = Color("labelColor")
    
    var themeName: String = "Green"
}

final class Blue: Theme
{
    var button: Color = Color("AccentColor_Blue")
    
    var accent: Color = Color("AccentColor_Blue")
    
    var background: Color  = Color("BackgroundColor_Blue")
    
    var label: Color = Color("labelColor")
    
    var text: Color = Color("labelColor")
    
    var themeName: String = "Blue"
}

class ThemeManager: ObservableObject
{
    @AppStorage("selectedTheme") var themeSelected = 0
    
    static let shared = ThemeManager()
    
    public var themes: [Theme] = [
        Default(),
        Green(),
        Blue(),
        MangaSoup(),
        Crunchyroll(),
        //Funimation(),
        Huntington()
    ]
    
    
    
    @Published var selectedTheme: Theme = Default()
    
    //@Published var accent: Color = selectedTheme.accent
    
    init(){ getTheme() }
    
    public func updateTheme(_ theme: Int)
    {
        self.selectedTheme = self.themes[theme]
        self.themeSelected = theme
    }
    
    func getTheme()
    {
        self.selectedTheme = self.themes[themeSelected]
    }
}
