//
//  MangaTransformer.swift
//  Ledger 0.1.2
//
//  Created by Malik Falana on 6/23/22.
//

import Foundation

@objc(MangaTransformer)
class MangaTransformer: NSSecureUnarchiveFromDataTransformer
{
    static let name = NSValueTransformerName(rawValue: String(describing: MangaTransformer.self))

    // Our class `Test` should in the allowed class list. (This is what the unarchiver uses to check for the right class)
    override public func transformedValue(_ value: Any?) -> Any? {
            guard let manga = value as? Manga else { return nil }
            
            do {
                let data = try NSKeyedArchiver.archivedData(withRootObject: manga, requiringSecureCoding: true)
                return data
            } catch {
                assertionFailure("Failed to transform `Manga` to `Data`")
                return nil
            }
        }
        
        override public func reverseTransformedValue(_ value: Any?) -> Any? {
            guard let data = value as? NSData else { return nil }
            
            do {
                
                let manga = try NSKeyedUnarchiver.unarchivedObject(ofClass: NSArray.self, from: data as Data)
                return manga
            } catch {
                assertionFailure("Failed to transform `Data` to `UIColor`")
                return nil
            }
        }

    /// Registers the transformer.
    public static func register() {
        let transformer = MangaTransformer()
        ValueTransformer.setValueTransformer(transformer, forName: name)
    }
    
}
@objc(ChapterTransformer)
class ChapterTransformer: NSSecureUnarchiveFromDataTransformer
{
    static let name = NSValueTransformerName(rawValue: String(describing: ChapterTransformer.self))

    // Our class `Test` should in the allowed class list. (This is what the unarchiver uses to check for the right class)
    override static var allowedTopLevelClasses: [AnyClass] {
        return [Chapter.self]
        //return [Chapter.self]
    }

    /// Registers the transformer.
    public static func register() {
        let transformer = ChapterTransformer()
        ValueTransformer.setValueTransformer(transformer, forName: name)
    }
    
}


@objc(MyTestClassValueTransformer)
final class MyTestClassValueTransformer: NSSecureUnarchiveFromDataTransformer {

    // The name of the transformer. This is what we will use to register the transformer `ValueTransformer.setValueTrandformer(_"forName:)`.
    static let name = NSValueTransformerName(rawValue: String(describing: MyTestClassValueTransformer.self))

    // Our class `Test` should in the allowed class list. (This is what the unarchiver uses to check for the right class)
    override static var allowedTopLevelClasses: [AnyClass] {
        return [Manga.self, Chapter.self]
        //return [Chapter.self]
    }

    /// Registers the transformer.
    public static func register() {
        let transformer = MyTestClassValueTransformer()
        ValueTransformer.setValueTransformer(transformer, forName: name)
    }
}
