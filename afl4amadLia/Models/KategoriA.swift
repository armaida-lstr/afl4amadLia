//
//  KategoriA.swift
//  afl4amadLia
//
//  Created by MacBook Pro on 03/06/22.
//

import Foundation

enum KategoriA: String, CaseIterable {
    case general
    case business
    case entertainment
    case health
    case science
    case sports
    case technology
    

  
    
    var text: String {
        if self == .general {
            return "The Sire News"
        }
        return rawValue.capitalized
    }
}

extension KategoriA: Identifiable {
    var id: Self { self }
}
