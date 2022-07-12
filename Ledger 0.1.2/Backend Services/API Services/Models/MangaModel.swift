//
//  MangaModel.swift
//  Ledger.0.0.2
//
//  Created by Malik Falana on 5/29/22.
//

import Foundation
import SwiftUI

struct MangaResponse: Codable
{
    let result, response: String
    let data: Manga
    
    struct Manga: Codable
    {
        let id: String
        let type: RelationshipType
        let attributes: Attributes
        let relationships: [Relationship]
        
        enum RelationshipType: String, Codable
        {
            case artist = "artist"
            case author = "author"
            case coverArt = "cover_art"
            case manga = "manga"
        }
        
        struct Attributes: Codable
        {
            let title: Title
            let altTitles: [AltTitle]
            let attributesDescription: Description
            let isLocked: Bool
            let links: Links
            let originalLanguage, lastVolume, lastChapter, publicationDemographic: String
            let status: String
            let year: Int
            let contentRating: String
            let tags: [Tag]
            let state: String
            let chapterNumbersResetOnNewVolume: Bool
            let createdAt, updatedAt: Date
            let version: Int
            let availableTranslatedLanguages: [String]
            
            struct Title: Codable
            {
                let en: String
            }
            
            struct AltTitle: Codable
            {
                let ja, ru, sr, hi: String?
                let bn, th, my, zhHk: String?
                let zh, ko, he, ar: String?
            }
            
            struct Description: Codable
            {
                let bg, cs, de, en: String?
                let es, fi, fr, id: String?
                let it, ja, pl, pt: String?
                let ru, sr, tr: String?
            }
            
            struct Links: Codable
            {
                let al, ap, bw, kt: String?
                let mu: String?
                let amz, ebj: String?
                let mal: String?
                let raw, engtl: String?
            }
            
            struct Tag: Codable
            {
                let id, type: String
                let attributes: Attributes
                let relationships: [JSONAny?]
                
                struct Attributes: Codable
                {
                    let name: Title
                    let attributesDescription: [JSONAny?]
                    let group: String
                    let version: Int
                }
            }
        }
        
        struct Relationship: Codable
        {
            let id: String
            let type: RelationshipType
            let attributes: Attributes?
            let related: Related?
            
            
            enum Related: String, Codable
            {
                case adaptedFrom = "adapted_from"
                case alternateStory = "alternate_story"
                case alternateVersion = "alternate_version"
                case basedOn = "based_on"
                case colored = "colored"
                case doujinshi = "doujinshi"
                case mainStory = "main_story"
                case prequel = "prequel"
                case preserialization = "preserialization"
                case sameFranchise = "same_franchise"
                case sequel = "sequel"
                case sharedUniverse = "shared_universe"
                case sideStory = "side_story"
                case spinOff = "spin_off"
            }
            
            struct Attributes: Codable
            {
                let name: String?
                let imageURL: String?
                let biography: [JSONAny]
                let twitter, pixiv, melonBook, fanBox: String?
                let booth, nicoVideo, skeb, fantia: String?
                let tumblr, youtube, weibo, naver: String?
                let website: String?
                let createdAt, updatedAt: Date
                let version: Int
                let attributesDescription, volume, fileName, locale: String?
                
                enum CodingKeys: String, CodingKey
                {
                    case name
                    case imageURL = "imageUrl"
                    case biography, twitter, pixiv, melonBook, fanBox, booth, nicoVideo, skeb, fantia, tumblr, youtube, weibo, naver, website
                    case attributesDescription = "description"
                    case volume, fileName, locale, createdAt, updatedAt, version

                }
            }
        }
    }
}

// MARK: - DataClass


// MARK: - DataAttributes




/*struct Tag: Codable
{
    let id, type: String
    let attributes: TagAttributes
    let relationships: [JSONAny]
    
    struct TagAttributes: Codable
    {
        let name: Description
        let attributesDescription: [JSONAny]
        let group: String
        let version: Int

        enum CodingKeys: String, CodingKey
        {
            case name
            case attributesDescription = "description"
            case group, version
        }
    }
}*/
