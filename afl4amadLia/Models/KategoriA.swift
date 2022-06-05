//
//  KategoriA.swift
//  afl4amadLia
//
//  Created by MacBook Pro on 29/05/22.
//

import Foundation

enum KategoriA: String, CaseIterable {
    case general
    case business
    case technology
    case entertainment
    case sports
    case science
    case health
    
    var text: String {
        if self == .general {
            return "Top Headlines"
        }
        return rawValue.capitalized
    }
}

extension KategoriA: Identifiable {
    var id: Self { self }
}
