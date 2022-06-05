//
//  APIResponse.swift
//  afl4amadLia
//
//  Created by MacBook Pro on 29/05/22.
//

import Foundation

struct APIResponse: Decodable {
    
    let status: String
    let totalResults: Int?
    let articles: [Article]?
    
    let code: String?
    let message: String?
    
}
