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
        let type: String
        let attributes: Attributes
        let relationships: [Relationship]

        struct Relationship: Codable
        {
            let id: String
            let type: String
            let attributes: Attributes?
            let related: String?

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
                let biography: BiographyUnion?
                let twitter, pixiv, melonBook, fanBox: String?
                let booth, nicoVideo, skeb, fantia: String?
                let tumblr, youtube, weibo, naver: String?
                let website: String?
                let createdAt, updatedAt: Date?
                let version: Int?
                let attributesDescription: String? //DescriptionEnum?
                let volume, fileName: String?
                let locale: String?


                enum CodingKeys: String, CodingKey
                {
                    case name
                    case imageURL = "imageUrl"
                    case biography, twitter, pixiv, melonBook, fanBox, booth, nicoVideo, skeb, fantia, tumblr, youtube, weibo, naver, website
                    case attributesDescription = "description"
                    case volume, fileName, locale, createdAt, updatedAt, version
                }

                enum DescriptionEnum: String, Codable
                {
                    case empty = ""
                    case original = "Original"
                    case webCover = "Web Cover"
                }

                enum BiographyUnion: Codable
                {
                    case anythingArray([JSONAny])
                    case biographyClass(Title)

                    init(from decoder: Decoder) throws {
                        let container = try decoder.singleValueContainer()
                        if let x = try? container.decode([JSONAny].self) {
                            self = .anythingArray(x)
                            return
                        }
                        if let x = try? container.decode(Title.self) {
                            self = .biographyClass(x)
                            return
                        }
                        throw DecodingError.typeMismatch(BiographyUnion.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for BiographyUnion"))
                    }

                    func encode(to encoder: Encoder) throws {
                        var container = encoder.singleValueContainer()
                        switch self {
                        case .anythingArray(let x):
                            try container.encode(x)
                        case .biographyClass(let x):
                            try container.encode(x)
                        }
                    }
                }

                // MARK: - BiographyClass
//                struct BiographyClass: Codable
//                {
//                    let en: String
//                    let jaRo, es, ru: String?
//                    let ja, ko, uk, zh: String?
//                    let zhHk, esLa, vi, fa: String?
//                    let th, ro, ar, ne: String?
//                    let hi, pl, cs, sr: String?
//                    let bn, my, he, id: String?
//                    let zhRo, null, de, it: String?
//                    let fr, nl, tr, bg: String?
//                    let hu, et, sv, pt: String?
//                    let la, ca, el, mn: String?
//                    let ptBr, ms: String?
//
//                    enum CodingKeys: String, CodingKey
//                    {
//                        case jaRo = "ja-ro"
//                        case es, en, ru, ja, ko, uk, zh
//                        case zhHk = "zh-hk"
//                        case esLa = "es-la"
//                        case vi, fa, th, ro, ar, ne, hi, pl, cs, sr, bn, my, he, id
//                        case zhRo = "zh-ro"
//                        case null = "NULL"
//                        case de, it, fr, nl, tr, bg, hu, et, sv, pt, la, ca, el, mn
//                        case ptBr = "pt-br"
//                        case ms
//                    }
//                }

            }
        }

        struct Title: Codable
        {
            let en, jaRo, es, ru: String?
            let ja, ko, uk, zh: String?
            let zhHk, esLa, vi, fa: String?
            let th, ro, ar, ne: String?
            let hi, pl, cs, sr: String?
            let bn, my, he, id: String?
            let zhRo, null, de, it: String?
            let fr, nl, tr, bg: String?
            let hu, et, sv, pt: String?
            let la, ca, el, mn: String?
            let ptBr, ms, fi: String?
            let no, koRo, da: String?



//            enum CodingKeys: String, CodingKey
//            {
//                case jaRo = "ja-ro"
//                case es, en, ru, ja, ko, uk, zh
//                case zhHk = "zh-hk"
//                case esLa = "es-la"
//                case vi, fa, th, ro, ar, ne, hi, pl, cs, sr, bn, my, he, id
//                case zhRo = "zh-ro"
//                case null = "NULL"
//                case de, it, fr, nl, tr, bg, hu, et, sv, pt, la, ca, el, mn
//                case ptBr = "pt-br"
//                case ms, fi
//            }
        }

        enum RelationshipType: String, Codable
        {
            case artist = "artist"
            case author = "author"
            case coverArt = "cover_art"
            case manga = "manga"
        }

        enum OriginalLanguage: String, Codable
        {
            case en = "en" //Manga
            case ja = "ja" //Manga
            case ko = "ko" //Manwha
            case zh = "zh" //Manhua
        }

        struct Attributes: Codable
        {
            let title: Title?
            let altTitles: [Title]?
            let attributesDescription: DescriptionUnion?
            let isLocked: Bool?
            let links: LinksUnion?
            let originalLanguage: String?
            let lastVolume, lastChapter: String?
            let publicationDemographic: String?
            let status: String?
            let year: Int?
            let contentRating: String?
            let tags: [Tag]
            let state: String?
            let chapterNumbersResetOnNewVolume: Bool?
            let createdAt, updatedAt: Date?
            let version: Int?
            let availableTranslatedLanguages: [String?]

            enum LinksUnion: Codable
            {
                case anythingArray([JSONAny])
                case linksClass(LinksClass)
                case null

                init(from decoder: Decoder) throws {
                    let container = try decoder.singleValueContainer()
                    if let x = try? container.decode([JSONAny].self) {
                        self = .anythingArray(x)
                        return
                    }
                    if let x = try? container.decode(LinksClass.self) {
                        self = .linksClass(x)
                        return
                    }
                    if container.decodeNil() {
                        self = .null
                        return
                    }
                    throw DecodingError.typeMismatch(LinksUnion.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for LinksUnion"))
                }

                func encode(to encoder: Encoder) throws {
                    var container = encoder.singleValueContainer()
                    switch self {
                    case .anythingArray(let x):
                        try container.encode(x)
                    case .linksClass(let x):
                        try container.encode(x)
                    case .null:
                        try container.encodeNil()
                    }
                }
            }

            struct LinksClass: Codable
            {
                let mu: String?
                let raw: String?
                let engtl: String?
                let al, ap, kt, nu: String?
                let amz: String?
                let mal, bw: String?
                let ebj: String?
                let cdj: String?

            }

            enum CodingKeys: String, CodingKey
            {
                case title, altTitles
                case attributesDescription = "description"
                case isLocked, links, originalLanguage, lastVolume, lastChapter, publicationDemographic, status, year, contentRating, tags, state, chapterNumbersResetOnNewVolume, createdAt, updatedAt, version, availableTranslatedLanguages
            }

            enum DescriptionUnion: Codable
            {
                case anythingArray([JSONAny])
                case descriptionClass(Title)
            
                init(from decoder: Decoder) throws {
                        let container = try decoder.singleValueContainer()
                        if let x = try? container.decode([JSONAny].self) {
                            self = .anythingArray(x)
                            return
                        }
                        if let x = try? container.decode(Title.self) {
                            self = .descriptionClass(x)
                            return
                        }
                        throw DecodingError.typeMismatch(DescriptionUnion.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for DescriptionUnion"))
                    }

                    func encode(to encoder: Encoder) throws {
                        var container = encoder.singleValueContainer()
                        switch self {
                        case .anythingArray(let x):
                            try container.encode(x)
                        case .descriptionClass(let x):
                            try container.encode(x)
                        }
                    }
            }


            enum PublicationDemographic: String, Codable
            {
                case josei = "josei"
                case seinen = "seinen"
                case shoujo = "shoujo"
                case shounen = "shounen"
                //case none = "none"
            }

            enum Status: String, Codable
            {
                case cancelled = "cancelled"
                case completed = "completed"
                case hiatus = "hiatus"
                case ongoing = "ongoing"
            }

            enum ContentRating: String, Codable
            {
                case safe = "safe"
                case suggestive = "suggestive"
                case erotica = "erotica"
                case pornographic = "pornographic"
            }

            struct Tag: Codable
            {
                let id: String
                let type: String
                let attributes: TagAttributes
                let relationships: [JSONAny]

                enum TagType: String, Codable
                {
                    case tag = "tag"
                }

                struct TagAttributes: Codable
                {
                    let name: Title
                    let attributesDescription: [JSONAny]
                    let group: String
                    let version: Int

                    enum CodingKeys: String, CodingKey
                    {
                        case name
                        case attributesDescription = "description"
                        case group, version
                    }

                    enum Group: String, Codable
                    {
                        case content = "content"
                        case format = "format"
                        case genre = "genre"
                        case theme = "theme"
                    }
                }
            }

            enum State: String, Codable
            {
                case published = "published"
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
