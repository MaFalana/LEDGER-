//
//  Base.swift
//  Ledger 0.1.2
//
//  Created by Malik Falana on 6/30/22.
//

import Foundation

struct Base: Codable
{
    let result: String
    let response: String
    let data: [MangaDex]
    let limit: Int
    let offset: Int
    let total: Int
}
