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
    
    private var ASH: [Tag]
    {
        //return (libraryData.data ?? []) as! [Manga]
        return Array(_immutableCocoaArray: Chapter.source?.tags ?? [])
    }
    
    var Chapters: [Chapter]
    {
        return Array(_immutableCocoaArray: Chapter.source?.chapters ?? []).sorted{Float($0.chapterNumber!)! < Float($1.chapterNumber!)!}
    }
    
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
            return "no pages left"
        }
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
            
            if ASH.contains{ $0.name!.contains("Long Strip") }
            {
                ZStack
                {
                    themeManager.selectedTheme.background.ignoresSafeArea(.all)
                    Pager(page: page, data: items, id: \.self)
                    {
                        index in
                        
                        ReadView(urlString: "\(network.pages?.baseURL ?? "")/data/\(network.pages?.chapter.hash ?? "")/\(network.pages?.chapter.data[index] ?? "")" )
                        //ReadView(urlString: nums[index])
                            .onTapGesture(count: 1) {withAnimation{self.hideNavigationBar.toggle();print("The Index of this page is \(index)")}}
                            .onAppear{print("Index is \(index)")}
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
                        VStack
                        {
                            Slider(value: $sliderValue, in: sliderRange, step: sliderStep).disabled(true)
                            
                            HStack
                            {
                                Spacer()
                                Spacer()
                                Text("\(Int(sliderValue)) of \(Pages)").font(.caption2).multilineTextAlignment(.center) /* Need to make smaller */
                                Spacer()
                                Text(PageCounter).font(.caption2).foregroundColor(.gray).multilineTextAlignment(.trailing) //Updates when page updated
                            }
                        }.opacity(hideNavigationBar ? 0 : 1)
                        
                    }
                    
                    ToolbarItemGroup(placement: .principal)
                    {
                        Text(ReaderTitle)
                        .lineLimit(1)
                        .font(.headline)
                        .multilineTextAlignment(.center)
                        .opacity(hideNavigationBar ? 0 : 1)
                    }
                    
                    ToolbarItemGroup(placement: .navigationBarLeading)
                    {
                        Button(action: {presentationMode.wrappedValue.dismiss()}) {Image(systemName: "xmark.circle.fill")}.imageScale(.large).opacity(hideNavigationBar ? 0 : 1)
                        
                        Chapter_Menu(Chapters: Chapters).opacity(hideNavigationBar ? 0 : 1)
                    }
                    
                    ToolbarItemGroup(placement: .navigationBarTrailing)
                    {
                        Reader_Menu().opacity(hideNavigationBar ? 0 : 1)
                        
                            
                        Button(action: {}) {Image(systemName: "square.stack.3d.up")}.imageScale(.large).opacity(hideNavigationBar ? 0 : 1)
                
                    }
                   
                }
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
                        
                        VStack
                        {
                            Slider(value: $sliderValue, in: sliderRange, step: sliderStep).disabled(true)
                            
                            HStack
                            {
                                Spacer()
                                Spacer()
                                Text("\(Int(sliderValue)) of \(Pages)").font(.caption2).multilineTextAlignment(.center) /* Need to make smaller */
                                Spacer()
                                Text(PageCounter).font(.caption2).foregroundColor(.gray).multilineTextAlignment(.trailing) //Updates when page updated
                            }
                        }.opacity(hideNavigationBar ? 0 : 1)
                        
                    }
                    
                    ToolbarItemGroup(placement: .principal)
                    {
                        Text(ReaderTitle)
                        .lineLimit(1)
                        .font(.headline)
                        .multilineTextAlignment(.center)
                        .opacity(hideNavigationBar ? 0 : 1)
                    }
                    
                    ToolbarItemGroup(placement: .navigationBarLeading)
                    {
                        Button(action: {presentationMode.wrappedValue.dismiss()}) {Image(systemName: "xmark.circle.fill")}.imageScale(.large).opacity(hideNavigationBar ? 0 : 1)
                        
                        Chapter_Menu(Chapters: Chapters).opacity(hideNavigationBar ? 0 : 1)
                    }
                    
                    ToolbarItemGroup(placement: .navigationBarTrailing)
                    {
                        Reader_Menu().opacity(hideNavigationBar ? 0 : 1)
                        
                            
                        Button(action: {}) {Image(systemName: "square.stack.3d.up")}.imageScale(.large).opacity(hideNavigationBar ? 0 : 1)
                
                    }
                   
                }
            }
            
        }.task{ await network.fetchPage(chapterId: Chapter.id!) }
    }
}
