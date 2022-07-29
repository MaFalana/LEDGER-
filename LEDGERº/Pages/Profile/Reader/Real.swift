//
//  Real.swift
//  Ledger 0.1.2
//
//  Created by Malik Falana on 6/5/22.
//
import SwiftUIPager
import SwiftUI
//import SwiftUIX

struct FC: View  //TabBar
{
    @EnvironmentObject private var themeManager: ThemeManager
    //@State var tabSelection = 1
    @State var showMenu = false
    //var screenWidth = UIScreen.main.bounds.width
    
    let Chapter: Chapter
    
    var ReaderTitle: String
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
    
    var ChapterID: String
    {
        return Chapter.id!
    }
    
    var MangaID: String
    {
        return Chapter.source!.id
    }
    
    var Pages: Int // number of pages in chapter
    {
        return Int(Chapter.pages)
    }
    
    private var ASH: [String]
    {
        //return (libraryData.data ?? []) as! [Manga]
        let FOREX: [Tag] = Array(_immutableCocoaArray: Chapter.source?.tags ?? [])
        var SUM: [String] = []
        
        for i in FOREX
        {
            SUM.append(i.name!)
            //SUM.
        }
        return SUM
        
    }
    
//    private var SAM: [String]
//    {
//        for i in ASH
//        {
//            i.name
//        }
//    }
 
    //var sem: ClosedRange<Int>
    @State private var sliderValue: Double = 1
    private let sliderStep: Double = 1
    //@State var currentPage: Int = 1
    
    @State private var hideNavigationBar = false
    @State private var hideToolBar = false
    
    @State var selectedPage: Double = 1
    
    @EnvironmentObject var network: CollectionLoader
    @Environment(\.presentationMode) var presentationMode
    
    @StateObject var page: Page = .first()
    
    
    @State private var scale = 1.0
    @State private var lastScale = 1.0
    private let minScale = 1.0
    private let maxScale = 5.0
    
    var zoom: some Gesture
    {
        MagnificationGesture()
            .onChanged { state in  adjustScale(from: state) }
            .onEnded { state in withAnimation{ validateScaleLimits() }; lastScale = 1.0 }
    }
    
    func adjustScale(from state: MagnificationGesture.Value)
    {
        let delta = state / lastScale
        scale *= delta
        lastScale = state
    }
    
    func getMinimumScaleAllowed() -> CGFloat
    {
        return max(scale, minScale)
    }
    
    func getMaximumScaleAllowed() -> CGFloat
    {
        return min(scale, maxScale)
    }
    
    func validateScaleLimits()
    {
        scale = getMinimumScaleAllowed()
        scale = getMaximumScaleAllowed()
    }
    
//    private var orientation: VerticalSwipeDirection or HorizontalSwipeDirection
//    {
//        if tags.contains("long strip" || "web comic")
//        {
//            return .vertical()
//        }
//        else
//        {
//            return .horizontal()
//        }
//    }
   
    
    var body: some View
    {
        let sliderRange: ClosedRange<Double> = 1...Double(Pages)
        let items = Array(0..<Pages)
        //let Y: Int = Int(sliderValue) - 1
        //var newIndex: Int = Index + 1
        
        
        NavigationView
        {
//            PaginationView(axis: CRUDManager.shared.isOrient ? .vertical : .horizontal)
//            {
//                ForEach(0..<Pages)
//                {
//                    i in
//                    ReadView(urlString: "\(network.pages?.baseURL ?? "")/data/\(network.pages?.chapter.hash ?? "")/\(network.pages?.chapter.data[i] ?? "")" )
//                }
//            }
//            //.currentPageIndex($currentPage)
//            .pageControlBackgroundStyle(.automatic)
//            //.pageIndicatorAlignment(.bottom)
//            //.pageIndicatorTintColor(.)
//            //.currentPageIndicatorTintColor(.blue)
//
            //themeManager.selectedTheme.background.ignoresSafeArea(.all)
            
            if ASH.contains("Long Strip") || ASH.contains("Web Comic")
            {
                ZStack
                {
                    themeManager.selectedTheme.background.ignoresSafeArea(.all)
                    Pager(page: page, data: items, id: \.self)
                    {
                        index in
                        
                        ReadView(urlString: "\(network.pages?.baseURL ?? "")/data/\(network.pages?.chapter.hash ?? "")/\(network.pages?.chapter.data[index] ?? "")" )
                        //ReadView(urlString: nums[index])
                            .onTapGesture(count: 1) {withAnimation{self.hideNavigationBar.toggle()}}
                            .navigationBarHidden(hideNavigationBar)
                            .statusBar(hidden: hideNavigationBar)
                    }
                    .vertical()
                    .contentLoadingPolicy(.eager)
                    .onPageChanged({index in sliderValue = Double(index+1) })
                    .scaleEffect(scale).gesture(zoom)
                
                }
                .toolbar{
                    ToolbarItemGroup(placement: .bottomBar)
                    {
                        if hideNavigationBar == false
                        {
                            VStack
                            {
                                Slider(value: $sliderValue, in: sliderRange, step: sliderStep).disabled(true)
                                
                                HStack
                                {
                                    Spacer()
                                    Spacer()
                                    Text("\(Int(sliderValue)) of \(Pages)").font(.caption2) /* Need to make smaller */
                                    Spacer()
                                    if Pages - Int(sliderValue) > 1
                                    {
                                        Text("\(Pages - Int(sliderValue)) pages left").font(.caption2).foregroundColor(.gray) //Updates when page updated
                                    }
                                    else if Pages - Int(sliderValue) == 1
                                    {
                                        Text("\(Pages - Int(sliderValue)) page left").font(.caption2).foregroundColor(.gray) //Updates when page updated
                                    }
                                    else
                                    {
                                        Text("\(Pages - Int(sliderValue)) pages left").font(.caption2).foregroundColor(.gray).hidden()
                                    }
                                }
                            }
                        }
                        else
                        {
                            VStack
                            {
                                Slider(value: $sliderValue, in: sliderRange, step: sliderStep)
                                
                                HStack
                                {
                                    Spacer()
                                    Spacer()
                                    Text("\(Int(sliderValue)) of \(Pages)").font(.caption2) /* Need to make smaller */
                                    Spacer()
                                    if Pages - Int(sliderValue) > 1
                                    {
                                        Text("\(Pages - Int(sliderValue)) pages left").font(.caption2).foregroundColor(.gray) //Updates when page updated
                                    }
                                    else if Pages - Int(sliderValue) == 1
                                    {
                                        Text("\(Pages - Int(sliderValue)) page left").font(.caption2).foregroundColor(.gray) //Updates when page updated
                                    }
                                    else
                                    {
                                        Text("\(Pages - Int(sliderValue)) pages left").font(.caption2).foregroundColor(.gray).hidden()
                                    }
                                }
                            }.hidden()
                        }
                    }
                    
                    ToolbarItemGroup(placement: .navigationBarLeading)
                    {
                        Button(action: {presentationMode.wrappedValue.dismiss()}) {Image(systemName: "xmark.circle.fill")}.imageScale(.large)
                    }
                    
                    ToolbarItemGroup(placement: .navigationBarTrailing)
                    {
                        Reader_Menu()
                        
                            
                        Button(action: {}) {Image(systemName: "square.stack.3d.up")}.imageScale(.large)
                
                    }
                   
                }.navigationBarTitle(ReaderTitle, displayMode: .inline).lineLimit(1)
            }
            else
            {
                ZStack
                {
                    themeManager.selectedTheme.background.ignoresSafeArea(.all)
                    Pager(page: page, data: items, id: \.self)
                    {
                        index in
                        //ReadView(urlString: "https://mangaplus.shueisha.co.jp/viewer/1000488")
                        ReadView(urlString: "\(network.pages?.baseURL ?? "")/data/\(network.pages?.chapter.hash ?? "")/\(network.pages?.chapter.data[index] ?? "")" )
                        //ReadView(urlString: nums[index])
                            .onTapGesture(count: 1) {withAnimation{self.hideNavigationBar.toggle()}}
                            .navigationBarHidden(hideNavigationBar)
                            .statusBar(hidden: hideNavigationBar)
                    }
                    //CRUDManager.shared.isOrient ? .vertical() : .horizontal()
                    .contentLoadingPolicy(.eager)
                    .onPageChanged({index in sliderValue = Double(index+1) })
                    .scaleEffect(scale).gesture(zoom)
                
                }
                .toolbar{
                    ToolbarItemGroup(placement: .bottomBar)
                    {
                        if hideNavigationBar == false
                        {
                            VStack
                            {
                                Slider(value: $sliderValue, in: sliderRange, step: sliderStep).disabled(true)
                                
                                HStack
                                {
                                    Spacer()
                                    Spacer()
                                    Text("\(Int(sliderValue)) of \(Pages)").font(.caption2) /* Need to make smaller */
                                    Spacer()
                                    if Pages - Int(sliderValue) > 1
                                    {
                                        Text("\(Pages - Int(sliderValue)) pages left").font(.caption2).foregroundColor(.gray) //Updates when page updated
                                    }
                                    else if Pages - Int(sliderValue) == 1
                                    {
                                        Text("\(Pages - Int(sliderValue)) page left").font(.caption2).foregroundColor(.gray) //Updates when page updated
                                    }
                                    else
                                    {
                                        Text("\(Pages - Int(sliderValue)) pages left").font(.caption2).foregroundColor(.gray).hidden()
                                    }
                                }
                            }
                        }
                        else
                        {
                            VStack
                            {
                                Slider(value: $sliderValue, in: sliderRange, step: sliderStep)
                                
                                HStack
                                {
                                    Spacer()
                                    Spacer()
                                    Text("\(Int(sliderValue)) of \(Pages)").font(.caption2) /* Need to make smaller */
                                    Spacer()
                                    if Pages - Int(sliderValue) > 1
                                    {
                                        Text("\(Pages - Int(sliderValue)) pages left").font(.caption2).foregroundColor(.gray) //Updates when page updated
                                    }
                                    else if Pages - Int(sliderValue) == 1
                                    {
                                        Text("\(Pages - Int(sliderValue)) page left").font(.caption2).foregroundColor(.gray) //Updates when page updated
                                    }
                                    else
                                    {
                                        Text("\(Pages - Int(sliderValue)) pages left").font(.caption2).foregroundColor(.gray).hidden()
                                    }
                                }
                            }.hidden()
                        }
                    }
                    
                    ToolbarItemGroup(placement: .navigationBarLeading)
                    {
                        Button(action: {presentationMode.wrappedValue.dismiss()}) {Image(systemName: "xmark.circle.fill")}.imageScale(.large)
                    }
                    
                    ToolbarItemGroup(placement: .navigationBarTrailing)
                    {
                        Reader_Menu()
                        
                            
                        Button(action: {}) {Image(systemName: "square.stack.3d.up")}.imageScale(.large)
                
                    }
                   
                }.navigationBarTitle(ReaderTitle, displayMode: .inline).lineLimit(1)
            }
            
                
        
                
            
        }.task{ await network.fetchPage(chapterId: Chapter.id!) }
    }
}

//struct offlineReader: View  //TabBar
//{
//    @EnvironmentObject private var themeManager: ThemeManager
//    //@State var tabSelection = 1
//    @State var showMenu = false
//    //var screenWidth = UIScreen.main.bounds.width
//    
//    
//    let ReaderTitle: String
//    let ChapterID: String
//    let MangaID: String
//    let Pages: [String]? // number of pages in chapter
// 
//    //var sem: ClosedRange<Int>
//    @State private var sliderValue: Double = 1
//    private let sliderStep: Double = 1
//    
//    @State private var hideNavigationBar = false
//    @State private var hideToolBar = false
//    
//    @State var selectedPage: Double = 1
//    
//    //@EnvironmentObject var network: CollectionLoader
//    @Environment(\.presentationMode) var presentationMode
//    
//    @StateObject var page: Page = .first()
//    
//    
//    @State private var scale = 1.0
//    @State private var lastScale = 1.0
//    private let minScale = 1.0
//    private let maxScale = 5.0
//    
//    var zoom: some Gesture
//    {
//        MagnificationGesture()
//            .onChanged { state in  adjustScale(from: state) }
//            .onEnded { state in withAnimation{ validateScaleLimits() }; lastScale = 1.0 }
//    }
//    
//    func adjustScale(from state: MagnificationGesture.Value)
//    {
//        let delta = state / lastScale
//        scale *= delta
//        lastScale = state
//    }
//    
//    func getMinimumScaleAllowed() -> CGFloat
//    {
//        return max(scale, minScale)
//    }
//    
//    func getMaximumScaleAllowed() -> CGFloat
//    {
//        return min(scale, maxScale)
//    }
//    
//    func validateScaleLimits()
//    {
//        scale = getMinimumScaleAllowed()
//        scale = getMaximumScaleAllowed()
//    }
//    
////    private var orientation: VerticalSwipeDirection or HorizontalSwipeDirection
////    {
////        if tags.contains("long strip" || "web comic")
////        {
////            return .vertical()
////        }
////        else
////        {
////            return .horizontal()
////        }
////    }
//   
//    
//    var body: some View
//    {
//        let sliderRange: ClosedRange<Double> = 1...Double(Pages.count)
//        //let items =
//        //let Y: Int = Int(sliderValue) - 1
//        //var newIndex: Int = Index + 1
//        
//        
//        NavigationView
//        {
//            
//            
//                Pager(page: page, data: Array(0..<Pages.count), id: \.self)
//                {
//                    index in
//                    
//                    ReadView(urlString: Pages[index] )
//                        .onTapGesture(count: 1) {withAnimation{self.hideNavigationBar.toggle()}}
//                        .navigationBarHidden(hideNavigationBar)
//                        .statusBar(hidden: hideNavigationBar)
//                }
//                //.horizontal()
//                //.vertical()
//                .contentLoadingPolicy(.eager)
//                .onPageChanged({index in sliderValue = Double(index+1) })
//                .scaleEffect(scale).gesture(zoom)
//                .toolbar{
//                    ToolbarItemGroup(placement: .bottomBar)
//                    {
//                        if hideNavigationBar == false
//                        {
//                            VStack
//                            {
//                                Slider(value: $sliderValue, in: sliderRange, step: sliderStep)
//                                
//                                HStack
//                                {
//                                    Spacer()
//                                    Spacer()
//                                    Text("\(Int(sliderValue)) of \(Pages)").font(.caption2) /* Need to make smaller */
//                                    Spacer()
//                                    if Pages - Int(sliderValue) > 1
//                                    {
//                                        Text("\(Pages - Int(sliderValue)) pages left").font(.caption2).foregroundColor(.gray) //Updates when page updated
//                                    }
//                                    else if Pages - Int(sliderValue) == 1
//                                    {
//                                        Text("\(Pages - Int(sliderValue)) page left").font(.caption2).foregroundColor(.gray) //Updates when page updated
//                                    }
//                                    else
//                                    {
//                                        Text("\(Pages - Int(sliderValue)) pages left").font(.caption2).foregroundColor(.gray).hidden()
//                                    }
//                                }
//                            }
//                        }
//                        else
//                        {
//                            VStack
//                            {
//                                Slider(value: $sliderValue, in: sliderRange, step: sliderStep)
//                                
//                                HStack
//                                {
//                                    Spacer()
//                                    Spacer()
//                                    Text("\(Int(sliderValue)) of \(Pages)").font(.caption2) /* Need to make smaller */
//                                    Spacer()
//                                    if Pages - Int(sliderValue) > 1
//                                    {
//                                        Text("\(Pages - Int(sliderValue)) pages left").font(.caption2).foregroundColor(.gray) //Updates when page updated
//                                    }
//                                    else if Pages - Int(sliderValue) == 1
//                                    {
//                                        Text("\(Pages - Int(sliderValue)) page left").font(.caption2).foregroundColor(.gray) //Updates when page updated
//                                    }
//                                    else
//                                    {
//                                        Text("\(Pages - Int(sliderValue)) pages left").font(.caption2).foregroundColor(.gray).hidden()
//                                    }
//                                }
//                            }.hidden()
//                        }
//                    }
//                    
//                    ToolbarItemGroup(placement: .navigationBarLeading)
//                    {
//                        Button(action: {presentationMode.wrappedValue.dismiss()}) {Image(systemName: "xmark.circle.fill")}.imageScale(.large)
//                    }
//                    
//                    ToolbarItemGroup(placement: .navigationBarTrailing)
//                    {
//                        Reader_Menu()
//                        
//                            
//                        Button(action: {}) {Image(systemName: "square.stack.3d.up")}.imageScale(.large)
//                
//                    }
//                   
//                }.navigationBarTitle(ReaderTitle, displayMode: .inline).lineLimit(1)
//                
//        
//                
//            
//        }
//    }
//}
