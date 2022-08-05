//
//  FB.swift
//  LEDGERº
//
//  Created by Malik Falana on 8/4/22.
//

import SwiftUI

struct FB: View
{
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var network: CollectionLoader
    @State private var selectedPageIndex = 0
    @State private var hideBar = false
    
    let Chapter: Chapter
    
    var Title: String
    {
        if Chapter.title == ""
        {
            return "Chapter \(Chapter.chapterNumber!)"
        }
        else
        {
            return Chapter.title!
        }
    }
    
    var Chapters: [Chapter]
    {
        return Array(_immutableCocoaArray: Chapter.source?.chapters ?? []).sorted{Float($0.chapterNumber!)! < Float($1.chapterNumber!)!}
    }
    
    var Pages: Int // number of pages in chapter
    {
        return Int(Chapter.pages)
    }

    var MangaID: String
    {
        return Chapter.source!.id
    }
    
    var Orientation: Axis.Set
    {
        let X: [Tag] = Array(_immutableCocoaArray: Chapter.source?.tags ?? [])
        
        if X.contains(where: { $0.name!.contains("Long Strip") })
        {
            return .vertical
        }
        else
        {
            return .horizontal
        }
    }
    
    var body: some View
    {
        NavigationView
        {
        //ScrollView(Orientation)
        //{
            TabView(selection: $selectedPageIndex)
            {
                ForEach(0..<Pages)
                {
                    i in
                ReadView(urlString: "\(network.pages?.baseURL ?? "")/data/\(network.pages?.chapter.hash ?? "")/\(network.pages?.chapter.data[i] ?? "")" ).tag(selectedPageIndex)
                
                    .onTapGesture(count: 1) {self.hideBar.toggle()}
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .automatic))
            .toolbar
            {
                ToolbarItemGroup(placement: .navigationBarLeading)
                {
                    Button(action: {presentationMode.wrappedValue.dismiss()}) {Image(systemName: "xmark.circle.fill")}.imageScale(.large).opacity(hideBar ? 0 : 1)
                    
                    Chapter_Menu(Chapters: Chapters).opacity(hideBar ? 0 : 1)
                }
                
                ToolbarItemGroup(placement: .principal)
                {
                    Text(Title)
                    .lineLimit(1)
                    .font(.headline)
                    .multilineTextAlignment(.center)
                    .opacity(hideBar ? 0 : 1)
                }
                
                ToolbarItemGroup(placement: .navigationBarTrailing)
                {
                    Reader_Menu().opacity(hideBar ? 0 : 1)
                    
                        
                    Button(action: {}) {Image(systemName: "square.stack.3d.up")}.imageScale(.large).opacity(hideBar ? 0 : 1)
                }
                
                ToolbarItemGroup(placement: .bottomBar)
                {
                    MangaSlider(Pages: Pages).opacity(hideBar ? 0 : 1)
                }
            }
            .task{ await network.fetchPage(chapterId: Chapter.id!) }
        //}
        }
    }
}


struct MangaSlider: View
{
    var Pages: Int
    @State private var sliderValue: Double = 1
    private let sliderStep: Double = 1
    private let sliderRange: ClosedRange<Double>
    
    var PageCounter: String
    {
        @State var Count = Pages - Int(sliderValue)
        
        if Count > 1
        {
            return "\(Count) pages left"
        }
        else if Count == 1
        {
            return "\(Count) page left"
        }
        else
        {
            return "\(Count) page left"
        }
    }
    
    init(Pages: Int)
    {
        self.Pages = Pages
        sliderRange = 1...Double(Pages)
    }
    
    var body: some View
    {
        VStack
        {
            HStack
            {
                Button(action: {sliderValue -= 2}) {Image(systemName: "backward.fill")}.imageScale(.large)
                Button(action: {sliderValue -= 1}) {Image(systemName: "arrowtriangle.backward.fill")}.imageScale(.large)
                Slider(value: $sliderValue, in: sliderRange, step: sliderStep)
                Button(action: {sliderValue += 1}) {Image(systemName: "arrowtriangle.forward.fill")}.imageScale(.large)
                Button(action: {sliderValue += 2}) {Image(systemName: "forward.fill")}.imageScale(.large)
            }
            HStack
            {
                Spacer()
                Spacer()
                Text("\(Int(sliderValue)) of \(Pages)").font(.caption2).multilineTextAlignment(.center) /* Need to make smaller */
                Spacer()
                Text(PageCounter).font(.caption2).foregroundColor(.gray).multilineTextAlignment(.trailing) //Updates when page updated
            }
        }
        
//        HStack //Arrows
//        {
//            Button(action: {sliderValue -= 2}) {Image(systemName: "backward.fill")}.imageScale(.large)
//            Button(action: {sliderValue -= 1}) {Image(systemName: "arrowtriangle.backward.fill")}.imageScale(.large)
//            Text("\(Int(sliderValue))/\(Pages)").multilineTextAlignment(.center)
//            Button(action: {sliderValue += 1}) {Image(systemName: "arrowtriangle.forward.fill")}.imageScale(.large)
//            Button(action: {sliderValue += 2}) {Image(systemName: "forward.fill")}.imageScale(.large)
//        }
    }
}
