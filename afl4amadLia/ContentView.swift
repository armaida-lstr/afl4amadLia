//
//  ContentView.swift
//  afl4amadLia
//
//  Created by MacBook Pro on 29/05/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            NewsTab()
            
                .tabItem {
                    Label("News", systemImage: "newspaper")
                }
            
//            SearchTab()
//                .tabItem {
//                    Label("Search", systemImage: "magnifyingglass")
//                }
            
            BookmarkTab()
                .tabItem {
                    Label("Favorites", systemImage: "heart.fill")
                }
        }
        
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
