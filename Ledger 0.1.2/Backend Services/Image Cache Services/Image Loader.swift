//
//  Image Loader.swift
//  Ledger.0.0.2
//
//  Created by Malik Falana on 5/29/22.
//

import Foundation
import SwiftUI

class UrlImageModel: ObservableObject
{
    @Published var image: UIImage?
    var urlString: String?
    var Library: Lib?
    var selectedManga: Manga
    var imageCache = ImageCache.getImageCache()
    
    init(urlString: String?,Library: Lib?, selectedManga: Manga)
    {
        self.urlString = urlString
        self.Library = Library
        self.selectedManga = selectedManga
        loadImage()
    }
    
    func loadImage()
    {
        if loadImageFromCache()
        {
            print("Cache hit")
            return
        }
        
        print("Cache miss, loading from url")
        loadImageFromUrl()
    }
    
    func loadImageFromCache() -> Bool
    {
        guard let urlString = urlString else
        {
            return false
        }
        
        guard let cacheImage = imageCache.get(forKey: urlString) else
        {
            return false
        }
        
        image = cacheImage
        return true
    }
    
    func loadImageFromUrl()
    {
        guard let urlString = urlString else
        {
            return
        }
        
        let url = URL(string: urlString)
        let task = URLSession.shared.dataTask(with: url ?? URL(string: "https://uploads.mangadex.org/covers/35b9f818-926b-4f4a-aa2b-0ac068986a73/56e9f6a1-3734-4f4a-84ed-1b25b21feba1.jpg")!, completionHandler: getImageFromResponse(data:response:error:))
        task.resume()
    }
    
    
    func getImageFromResponse(data: Data?, response: URLResponse?, error: Error?)
    {
        guard error == nil else
        {
            print("Error: \(error!)")
            return
        }
        guard let data = data else
        {
            print("No data found")
            return
        }
        
        DispatchQueue.main.async
        {
            guard let loadedImage = UIImage(data: data) else
            {
                return
            }
            
            self.imageCache.set(forKey: self.urlString!, image: loadedImage)
            self.image = loadedImage
        }
    }
}

class ImageCache {
    var cache = NSCache<NSString, UIImage>()
    
    func get(forKey: String) -> UIImage? {
        return cache.object(forKey: NSString(string: forKey))
    }
    
    func set(forKey: String, image: UIImage)
    {
        cache.setObject(image, forKey: NSString(string: forKey))
    }
}

extension ImageCache
{
    private static var imageCache = ImageCache()
    static func getImageCache() -> ImageCache
    {
        return imageCache
    }
}
