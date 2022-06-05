//
//  SimpanKosong.swift
//  afl4amadLia
//
//  Created by MacBook Pro on 01/06/22.
//

import SwiftUI

struct SimpanKosong: View {
    
    let text: String
    let image: Image?
    
    var body: some View {
        VStack(spacing: 8) {
            Spacer()
            if let image = self.image {
                image
                    .imageScale(.large)
                    .font(.system(size: 52))
            }
            Text(text)
            Spacer()
        }
    }
    
}

struct SimpanKosong_Previews: PreviewProvider {
    static var previews: some View {
        SimpanKosong(text: "No Bookmarks", image: Image(systemName: "heart.rectangle"))
    }
}
