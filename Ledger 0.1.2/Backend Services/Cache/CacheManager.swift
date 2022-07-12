//
//  CacheManager.swift
//  Ledger 0.1.2
//
//  Created by Malik Falana on 6/15/22.
//

import Foundation
import SwiftUI
//Might have to change V to CollectionResponse.mangaCollection
class CacheMangager
{
    //static let instance CacheManager()
    //private init() { }
    
    // var chapterCache: NSCache<AnyObject, AnyObject>
    // var mangaCache: NSCache<AnyObject, AnyObject>
}


final class CacheEntry<V>
{
    let key: String
    let value: V
    let expiredTimestamp: Date
    
    init(key: String, value: V, expiredTimestamp: Date)
    {
        self.key = key
        self.value = value
        self.expiredTimestamp = expiredTimestamp
    }
    
    func isCacheExpired(after date: Date = .now ) -> Bool //Intitalizes current date
    {
        date > expiredTimestamp //if date is larger than expirataion date
        
    }
}

actor InMemoryCache<V>
{
    private let cache: NSCache< NSString, CacheEntry<V> > = .init()
    private let expirationInterval: TimeInterval
    
    init(expirationInterval: TimeInterval)
    {
        self.expirationInterval = expirationInterval
    }
    
    func removeValue(forKey key: String)
    {
        cache.removeObject(forKey: key as NSString)
    }
    
    func removeAllValues()
    {
        cache.removeAllObjects()
    }
    
    func setValue(_ value: V?, forKey key: String) //Method to insert into cache using a key
    {
        if let value = value
        {
            let expiredTimestamp = Date().addingTimeInterval(expirationInterval)
            let cacheEntry = CacheEntry(key: key, value: value, expiredTimestamp: expiredTimestamp)
            cache.setObject(cacheEntry, forKey: key as NSString)
        }
        else
        {
            removeValue(forKey: key)
        }
    }
    
    func value(forKey key: String) -> V? // Method to retrive data from cache given a key
    {
        guard let entry = cache.object(forKey: key as NSString)
        else
        {
            return nil // Returns nil if nothing exists
        }
        // check to see if cache is still valid and not expired
        guard !entry.isCacheExpired(after: Date())
        else
        {
            removeValue(forKey: key)
            return nil
        }
        return entry.value
    }
}


class StructWrapper<T>: NSObject
{
    let value: T

    init(_ _struct: T) {
        value = _struct
    }
}


//class ItemCache: NSCache<NSString, StructWrapper<Item>>
//{
//    static let shared = ItemCache()
//
//    func cache(_ item: Item, for key: Int)
//    {
//        let keyString = NSString(format: "%d", key)
//        let itemWrapper = StructWrapper(item)
//        self.setObject(itemWrapper, forKey: keyString)
//    }
//
//    func getItem(for key: Int) -> Item?
//    {
//        let keyString = NSString(format: "%d", key)
//        let itemWrapper = self.object(forKey: keyString)
//        return itemWrapper?.value
//    }
//}
