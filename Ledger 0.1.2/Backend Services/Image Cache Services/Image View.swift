//
//  Image View.swift
//  Ledger.0.0.2
//
//  Created by Malik Falana on 5/29/22.
//

import Foundation
import SwiftUI

struct BrowseView: View
{
    //@EnvironmentObject var crudManager: CRUDManager
    @ObservedObject var urlImageModel: UrlImageModel
    //var covers: CoverResponse.Cover.Attributes?
    static var defaultImage = UIImage(named: "Placeholder")
    @State var isAdding = false
    //covers?.fileName
    init(urlString: String)
    {
        urlImageModel = UrlImageModel(urlString: urlString, Library: nil, selectedManga: Manga())
        //urlImageModel = UrlImageModel(urlString:"https://uploads.mangadex.org/covers/\(info.id)/\(viewModel.covers?.fileName ?? "")"
    }
    
    var body: some View
    {
        Image(uiImage: urlImageModel.image ?? BrowseView.defaultImage!).resizable().frame(width: 120, height: 170)
//        .contextMenu
//        {
////                Button(action: {print("Share")} ) {Label("Start Reading", systemImage: "square.and.arrow.up")}
////                Button(action: {print("Share")} ) {Label("More Details", systemImage: "square.and.arrow.up")}
//            Button(action: {isAdding.toggle()} )
//            {
//                Label("Add to Library", systemImage: "folder.badge.plus")
//
//            }.accentColor(.red).sheet(isPresented: $isAdding){ AddView(queuedManga: urlImageModel.selectedManga) }
//        }



    }
    
    
    
    
}

struct LibraryView: View
{
    //@EnvironmentObject var crudManager: CRUDManager
    @EnvironmentObject var network: CollectionLoader
    @ObservedObject var urlImageModel: UrlImageModel
    //let ID: String
    //let Library: Lib
    //var covers: CoverResponse.Cover.Attributes?
    static var defaultImage = UIImage(named: "Placeholder")
    //covers?.fileName
    init(urlString: String, Library: Lib, selectedManga: Manga)
    {
        urlImageModel = UrlImageModel(urlString: urlString, Library: Library, selectedManga: selectedManga)
        //urlImageModel = UrlImageModel(urlString:"https://uploads.mangadex.org/covers/\(info.id)/\(viewModel.covers?.fileName ?? "")"
    }
    
    var body: some View
    {
        Image(uiImage: urlImageModel.image ?? LibraryView.defaultImage!).resizable().frame(width: 120, height: 170)
            .contextMenu {
//                Button(action: {print("Share")} )
//                {
//                    Label("Start Reading", systemImage: "square.and.arrow.up")
//
//                }
//                NavigationLink(destination: Profile(info: urlImageModel.selectedManga).environmentObject(network))
//                {
//                    Button(action: {print("Share")} )
//                    {
//                        Label("More Details", systemImage: "square.and.arrow.up")
//
//                    }
//                }
                Button(action: {CRUDManager.shared.removeManga(Library: urlImageModel.Library!, selectedManga: urlImageModel.selectedManga)} )
                {
                    Label("Remove from Library", systemImage: "trash")
                    
                }.accentColor(.red)
            }



    }
    
    
    
    
}

struct ProfileView: View
{
    @ObservedObject var urlImageModel: UrlImageModel
    
    init(urlString: String)
    {
        urlImageModel = UrlImageModel(urlString: urlString, Library: nil, selectedManga: Manga())
    }
    
    var body: some View
    {
        Image(uiImage: urlImageModel.image ?? ProfileView.defaultImage!).resizable().scaledToFit().frame(width: 220, height: 320)
            .contextMenu
        {
            Button(action: {UIImageWriteToSavedPhotosAlbum(urlImageModel.image!, nil, nil, nil)} ) {Label("Save Image", systemImage: "square.and.arrow.down")}
            
        }
    }
    
    static var defaultImage = UIImage(named: "Placeholder")
}


struct ReadView: View
{
    @ObservedObject var urlImageModel: UrlImageModel
    
    init(urlString: String)
    {
        urlImageModel = UrlImageModel(urlString: urlString, Library: nil, selectedManga: Manga())
    }
    
    
    var body: some View
    {
        Image(uiImage: urlImageModel.image ?? ReadView.defaultImage!).resizable().scaledToFit().frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            .contextMenu
        {
            Button(action: {UIImageWriteToSavedPhotosAlbum(urlImageModel.image!, nil, nil, nil)} ) {Label("Save Image", systemImage: "square.and.arrow.down")}
            
        }
    }
    
    static var defaultImage = UIImage(named: "Placeholder")
    
    func saveImage()
    {
        UIImageWriteToSavedPhotosAlbum(Image(uiImage: urlImageModel.image ?? ReadView.defaultImage!).resizable().scaledToFit().frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height) as! UIImage, nil, nil, nil)
    }
}

struct SearchView: View
{
    @ObservedObject var urlImageModel: UrlImageModel
    
    init(urlString: String)
    {
        urlImageModel = UrlImageModel(urlString: urlString, Library: nil, selectedManga: Manga())
    }
    
    var body: some View
    {
        Image(uiImage: urlImageModel.image ?? SearchView.defaultImage!).resizable().frame(width: 90, height: 130)
    }
    
    static var defaultImage = UIImage(named: "Placeholder")
}

extension View
{
    func asUiImage() -> UIImage
    {
        var uiImage = UIImage(systemName: "exclamationmark.triangle.fill")!
       let controller = UIHostingController(rootView: self)

       if let view = controller.view {
            let contentSize = view.intrinsicContentSize
           view.bounds = CGRect(origin: .zero, size: contentSize)
           view.backgroundColor = .clear

           let renderer = UIGraphicsImageRenderer(size: contentSize)
           uiImage = renderer.image { _ in
               view.drawHierarchy(in: view.bounds, afterScreenUpdates: true)
           }
       }
      return uiImage
    }
}


