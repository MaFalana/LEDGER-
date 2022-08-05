//
//  Reader Menu.swift
//  Ledger 0.1.2
//
//  Created by Malik Falana on 6/16/22.
//

import SwiftUI
import Combine

struct Reader_Menu: View
{
    //@State private var selectedValue = "Horizontal"
    @State private var Orientation = 0
    
    private let sliderRange: ClosedRange<Double> = 0...1
    @State private var sliderValue: Double = 0.1
    private let sliderStep: Double = 0.1
    
    @State private var count = 0
    
    var body: some View
    {
        Menu
        {
            
            Section(header: Text("Orientation"))
            {
                HStack
                {
                    Text("Reader Orientation")
                    //Spacer()
                    Picker("Orientation", selection: $Orientation)
                    {
                        Text("Horizaontal").tag(0)
                        Text("Vertical").tag(1)
                    }
                    .fixedSize()
                    .pickerStyle(.segmented)
                }
            }
            
            Section(header: Text("Display"))
            {
                Slider(value: $sliderValue, in: sliderRange, step: sliderStep)
                BrightnessSlider()
            }
            
            Section(header: Text("Padding"))
            {
                VStack
                {
                    Stepper("Vertical Padding", value: $count)
                    Stepper("Horizontal Padding", value: $count)
                }
                
            }
            
        }
        label:
        {
            Image(systemName: "slider.horizontal.3").imageScale(.large)
        }
    }
}



struct Sort_Menu: View
{
    @State public var rowItems: Int = 3
    
    
    var body: some View
    {
        Menu
        {
            Button("3 Items") { rowItems = 3 }
            Button("4 Items") { rowItems = 4 }
            Button("5 Items") { rowItems = 5 }
        }
        label:
        {
            Image(systemName: "square.stack.3d.up").imageScale(.large)
        }
    }
}

struct chapterSort: View
{
    static let shared = chapterSort()
    @State private var chapterOrder = CRUDManager.shared.chapterOrder
    //@State private var selectedValue = 0
    @AppStorage("selectedValue") private var selectedValue = 0
    
    var body: some View
    {
        Menu
        {
            Picker("Chapter Order", selection: $chapterOrder )
            {
                Button("Source") { CRUDManager.shared.chapterOrder = 3 }.tag(3)
                Button("Chapter") { CRUDManager.shared.chapterOrder = 0 }.tag(0)
                //Button("5 Items") { rowItems = 5 }
            }
           
        }
        label:
        {
            Image(systemName: "line.3.horizontal.decrease").imageScale(.large)
        }
    }
}



struct BrightnessSlider: View
{
    @AppStorage("value") private var value = 0.1
    //@State private var value: Float = 0.1 // 1. declare a state for the value of the slider
    private let range: ClosedRange<Float> = 0...1
    private let step: Float = 0.1
    
    //UIScreen.main.brightness = CGFloat(0.5) //value of this property should be a number between 0.0 and 1.0, inclusive.
    
// 2. create a slider with a new Binding variable
    var body: some View
    {
        Slider(value: Binding(
            get: {
                self.value
            },
            set: {(newValue) in
                  self.value = newValue
                self.changeBrightness(Value: Float(newValue))
            }
        ))
    }


    func changeBrightness(Value: Float) // 3. create the function to call when the slider changes value
    {
        UIScreen.main.brightness = CGFloat(Value)
    }
}



struct Chapter_Menu: View
{
    @State private var selectedChapter = CRUDManager.shared.selectedChapter //First Chapter
    var Chapters: [Chapter]
    
    var body: some View
    {
        Menu
        {
            Picker("Chapters", selection: $selectedChapter)
            {
                ForEach(Chapters)
                {
                    i in
                    ChapterRow2(i: i).tag(i)
                }
            }
            .onReceive([self.selectedChapter].publisher.first())
            {
                value in
                CRUDManager.shared.changeChapter(X: value)
            }

            
        }
        label:
        {
            Image(systemName: "list.bullet").imageScale(.large)
        }
    }
}



struct ChapterRow2: View
{
    @EnvironmentObject var themeManager: ThemeManager
    let i: Chapter
    
    var Title: String // Chapter title
    {
        let X = i.title!
        
        if X == ""
        {
            return "Chapter \(i.chapterNumber!)"
        }
        else
        {
            return "Chapter \(i.chapterNumber!): \(X)"
        }
        
    }
    
    var ID: String
    {
        return i.id!
    }
    
    var Pages: Int // number of pages in chapter
    {
        return Int(i.pages)
    }
    

    var body: some View
    {
        Button(action: { print(i) } )
        {
            Text(Title).font(.caption2).lineLimit(1).padding()
        }
    }
}
