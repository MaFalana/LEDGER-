/*
 BigButton.swift
  LEDGERº
THis is the ui view for the Read first chapter button, and the read latest Chapter button
Created by Malik Falana on 7/24/22.
*/

import SwiftUI

struct BigButton: View
{
    @EnvironmentObject private var themeManager: ThemeManager
    @State var showFirst: Bool = false
    @State var showLatest: Bool = false
    @State private var showWebView = false
    let FirstChapter: Chapter
    let LatestChapter: Chapter
    
    var FirstTitle: String
    {
        if FirstChapter.title == ""
        {
            return "Chapter \(FirstChapter.chapterNumber!)"
        }
        else
        {
            return FirstChapter.title!
        }
    }
    
    var LastTitle: String
    {
        if LatestChapter.title == ""
        {
            return "Chapter \(LatestChapter.chapterNumber!)"
        }
        else
        {
            return LatestChapter.title!
        }
    }
    
    
    var body: some View
    {
        
        let BackGround: Color = themeManager.selectedTheme.accent
        let Label: Color = themeManager.selectedTheme.label
        
        HStack
        {
            Button("First Chapter\n\n\(FirstTitle)")
            {
                if FirstChapter.pages != 0
                {
                    showFirst.toggle()
                }
                else
                {
                    showWebView.toggle()
                }
                print(FirstChapter)
            }
            .buttonStyle(RoundedRectangleButtonStyle())
            .fullScreenCover(isPresented: $showFirst, content: {FC(Chapter: FirstChapter).accentColor(BackGround)} )
            .sheet(isPresented: $showWebView)
            {
                WebView(url: URL(string: FirstChapter.externalURL!)!)
            }
            
            //Spacer()
            
            Button("Latest Chapter\n\n\(LastTitle)")
            {
                if LatestChapter.pages != 0
                {
                    showLatest.toggle()
                }
                else
                {
                    showWebView.toggle()
                }
                print(LatestChapter)
            }
            .buttonStyle(RoundedRectangleButtonStyle())
            .fullScreenCover(isPresented: $showLatest, content: {FC(Chapter: LatestChapter).accentColor(BackGround)} )
            .sheet(isPresented: $showWebView)
            {
                WebView(url: URL(string: LatestChapter.externalURL!)!)
            }
        }
    }
}

