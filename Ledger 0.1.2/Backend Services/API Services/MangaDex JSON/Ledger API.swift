//
//  Ledger API.swift
//  Ledger 0.1.2
//
//  Created by Malik Falana on 7/6/22.
//

import Foundation

class DoBetter: ObservableObject
{
    func uploadLedger(ID: String) async
    {
        // create url
        guard let url = URL(string: "http://127.0.0.1:8000/upload/manga/\(ID)") //link to upload a manga to my API
        else
        {
            print("Error")
            return
        }
        
        // fetch data from url
        do
        {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            // decode data
            let decodedResponse = try? newJSONDecoder().decode(PageResponse.self, from: data)
            if let decodedResponse = decodedResponse
            {
                DispatchQueue.main.async
                {
                    
                }
                
            }

        }
        catch let error
        {
            print("ERROR = \(error.localizedDescription)")
        }
    }
}
