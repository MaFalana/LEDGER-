////
////  BackupModel.swift
////  LEDGERº
////
////  Created by Malik Falana on 8/3/22.
////
//
//import Foundation
//
//struct BackupModel: Codable
//{
//    let id: String
//    let creationDate: Date
//    let history: [History]
//    let libraries: [Lib]
//}
//
//class BACKUP: ObservableObject
//{
//    static let shared = BACKUP()
////    func getDocuments() -> URL
////    {
////        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
////        return paths[0]
////    }
////
////    func writeFile(Source: BackupModel)
////    {
////        let url = getDocuments().appendPathComponent("\(Source.id).json")
////        do
////        {
////            "TXT".write(to: url, atomically: true, encoding: .utf8)
////            let input = try String(contentsOf: url)
////            print(input)
////        }
////        catch let error
////        {
////            print(error.localizedDescription)
////        }
////    }
//    
//    func encodeBackup(Source: Backup)
//    {
//        do
//        {
//            let encodedBackup = try JSONEncoder().encode(Source)
//            print(encodedBackup)
//        }
//        catch let error
//        {
//            print(error)
//        }
//    }
//    
//    func decodeBackup(_ filename: String) //Function to decode backup from a json file
//    {
//        guard let file = Bundle.main.url(forResource: filename, withExtension: "json")
//        else
//        {
//           return print("Couldn't find \(filename) in main bundle.")
//        }
//        
//        do
//        {
//            let data = try Data(contentsOf: file)
//            let decodedBackup = try JSONDecoder().decode(Backup.self, from: data)
//            print(decodedBackup)
//            overwriteBackup(Source: decodedBackup)
//        }
//        catch let error
//        {
//            print("Couldn't parse \(filename) as \(Backup.self):\n\(error)")
//        }
//    }
//    
//    func overwriteBackup(Source: Backup) //Function to assign backup attributes
//    {
//        let Ω = CRUDManager.shared
//        let newLibrary = Source.libraries
//        let newHistory = Source.history
//        
//        Ω.activeLibraries.removeAll()
//        Ω.tabs.removeAll()
//        
//        Ω.activeLibraries = Array(newLibrary ?? [])
//        for i in Ω.activeLibraries
//        {
//            Ω.tabs.append(i.name)
//        }
//        Ω.Hist = Array(newHistory ?? [])
//        
//        print("Libraries: \(Source.libraries)")
//        print("History: \(Source.history)")
//        print(Ω.activeLibraries)
//        Ω.Save()
//
//    }
//}
