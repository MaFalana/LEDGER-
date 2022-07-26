//
//  ChapterModel.swift
//  Ledger.0.0.2
//
//  Created by Malik Falana on 5/29/22.
//

import Foundation
import SwiftUI

struct ChapterResponse: Codable
{
    let result, response: String
    let data: [Chapter]
    let limit, offset, total: Int
    
    
    struct Chapter: Codable, Identifiable
    {
        let id: String
        let type: DatumType
        let attributes: Attributes
        let relationships: [Relationship]
        
        enum DatumType: String, Codable
        {
            case chapter = "chapter"
        }
        
        struct Attributes: Codable
        {
            let title, volume, chapter: String?
            let translatedLanguage: TranslatedLanguage
            let externalURL: String?//JSONNull?
            let publishAt, readableAt, createdAt, updatedAt: Date
            let pages, version: Int

            enum CodingKeys: String, CodingKey
            {
                case volume, chapter, title, translatedLanguage
                case externalURL = "externalUrl"
                case publishAt, readableAt, createdAt, updatedAt, pages, version
            }
            
            enum TranslatedLanguage: String, Codable
            {
                case en = "en"
                
                case bg = "bg"
                case fr = "fr"
                case zh = "zh"
                case zhHk = "zh-hk"
                case ptBr = "pt-br"
                case es = "es"
                case esLa = "es-la"
                case jaRo = "ja-ro"
                case koRo = "ko-ro"
                case zhRo = "zh-ro"
                case vi = "vi"
            }
        }
        
        

        struct Relationship: Codable
        {
            let id: String
            let type: RelationshipType
            let attributes: RelationshipAttributes?
            
            enum RelationshipType: String, Codable
            {
                case manga = "manga"
                case scanlationGroup = "scanlation_group"
                case user = "user"
            }
            
            struct RelationshipAttributes: Codable
            {
                let name: String
                let altNames: [JSONAny]
                let locked: Bool
                let website: String?
                let ircServer, ircChannel: String?
                let discord: Discord
                let contactEmail: ContactEmail?
                let attributesDescription: Description?
                let twitter, mangaUpdates: JSONNull?
                let focusedLanguages: [EdLanguage]
                let official, verified, inactive: Bool
                let publishDelay: JSONNull?
                let createdAt, updatedAt: Date
                let version: Int

                enum CodingKeys: String, CodingKey
                {
                    case name, altNames, locked, website, ircServer, ircChannel, discord, contactEmail
                    case attributesDescription = "description"
                    case twitter, mangaUpdates, focusedLanguages, official, verified, inactive, publishDelay, createdAt, updatedAt, version
                }
                
                enum EdLanguage: String, Codable
                {
                    case en = "en"
                    
                    case bg = "bg"
                    case fr = "fr"
                    case zh = "zh"
                    case zhHk = "zh-hk"
                    case ptBr = "pt-br"
                    case es = "es"
                    case esLa = "es-la"
                    case jaRo = "ja-ro"
                    case koRo = "ko-ro"
                    case zhRo = "zh-ro"
                    case vi = "vi"
                    case id = "id"
                }
                
                enum ContactEmail: String, Codable {
                    case contactusShurimtranslationCOM = "contactus@shurimtranslation.com"
                    case dsHuynhduyGmailCOM = "ds.huynhduy@gmail.com"
                    case leduyvu74GmailCOM = "leduyvu74@gmail.com"
                    case lyallakova274GmailCOM = "lyallakova274@gmail.com"
                    case qndTranslationsGmailCOM = "qnd.translations@gmail.com"
                    case totemosugoiscansYahooCOM = "totemosugoiscans@yahoo.com"
                }
                
                enum Discord: String, Codable
                {
                    case cE6B7RS = "cE6b7rS"
                    case ewzD4Ym = "EwzD4ym"
                    case dApGB5NcAH = "DApGB5NcAH"
                    case the643291037560864788 = "643291037560864788"
                }

                enum Name: String, Codable
                {
                    case aNonymous = "/a/nonymous"
                    case allForMangaGroup = "All For Manga Group"
                    case cyanSteam = "Cyan Steam"
                    case desuVult = "Desu Vult"
                    case misfitsScans = "Misfits Scans"
                    case qnD = "QnD"
                    case sendiriScans = "SENDIRI scans"
                    case sssss = "SSSSS"
                    case theAfternoonTeashop = "The Afternoon Teashop"
                    case totemoSugoiScans = "Totemo Sugoi Scans"
                    case wickedHouseTranslation = "Wicked House Translation"
                }
            }
        }

        
        
        
        
        
        
        enum Description: String, Codable
        {
            case otherNameCroxxOverHTTPSMangadexOrgGroup299 = "Other name: Croxx-Over  \n  \n<https://mangadex.org/group/299>"
            case theHolyCrusadeAlwaysPrevailsDesuVult = "THE HOLY CRUSADE ALWAYS PREVAILS. DESU VULT!"
            case trayendoMangasAlEspañolDesdeEl15DeAbrilDe2015 = "Trayendo mangas al español desde el 15 de abril de 2015."
        }

        

    }
}





