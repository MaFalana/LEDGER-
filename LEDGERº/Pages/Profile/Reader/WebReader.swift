////
////  WebReader.swift
////  Ledger
////
////  Created by Malik Falana on 7/19/22.
////
//
//import SwiftUI
//import SwiftUIPager
//
//struct WebReader: View
//{
//    @EnvironmentObject private var themeManager: ThemeManager
//    @EnvironmentObject var network: CollectionLoader
//    @StateObject var page: Page = .first()
//    let ChapterID: String
//    let Pages: Int // number of pages in chapter
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
//    var body: some View
//    {
//        let sliderRange: ClosedRange<Double> = 1...Double(Pages)
//        let items = Array(0..<Pages)
//        
//        ZStack
//        {
//            themeManager.selectedTheme.background.ignoresSafeArea(.all)
//            Pager(page: page, data: items, id: \.self)
//            {
//                index in
//                
//                ReadView(urlString: "\(network.pages?.baseURL ?? "")/data/\(network.pages?.chapter.hash ?? "")/\(network.pages?.chapter.data[index] ?? "")" )
//                //ReadView(urlString: nums[index])
////                    .onTapGesture(count: 1) {withAnimation{self.hideNavigationBar.toggle()}}
////                    .navigationBarHidden(hideNavigationBar)
////                    .statusBar(hidden: hideNavigationBar)
//            }
//            .vertical()
//            .contentLoadingPolicy(.eager)
//            //.onPageChanged({index in sliderValue = Double(index+1) })
//            .scaleEffect(scale).gesture(zoom)
//            .task{ await network.fetchPage(chapterId: ChapterID) }
//        }
//    }
//}
//
//struct NormReader: View
//{
//    @EnvironmentObject private var themeManager: ThemeManager
//    @EnvironmentObject var network: CollectionLoader
//    @StateObject var page: Page = .first()
//    let ChapterID: String
//    let Pages: Int // number of pages in chapter
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
//    var body: some View
//    {
//        let sliderRange: ClosedRange<Double> = 1...Double(Pages)
//        let items = Array(0..<Pages)
//        
//        ZStack
//        {
//            themeManager.selectedTheme.background.ignoresSafeArea(.all)
//            Pager(page: page, data: items, id: \.self)
//            {
//                index in
//                
//                ReadView(urlString: "\(network.pages?.baseURL ?? "")/data/\(network.pages?.chapter.hash ?? "")/\(network.pages?.chapter.data[index] ?? "")" )
//                //ReadView(urlString: nums[index])
////                    .onTapGesture(count: 1) {withAnimation{self.hideNavigationBar.toggle()}}
////                    .navigationBarHidden(hideNavigationBar)
////                    .statusBar(hidden: hideNavigationBar)
//            }
//            .horizontal()
//            .contentLoadingPolicy(.eager)
//            //.onPageChanged({index in sliderValue = Double(index+1) })
//            .scaleEffect(scale).gesture(zoom)
//            .task{ await network.fetchPage(chapterId: ChapterID) }
//        }
//    }
//}
