//
//  ContentView.swift
//  afl4amadLia
//
//  Created by MacBook Pro on 25/05/22.
//

import SwiftUI

struct ContentView: View {
  
    var body: some View {
//        SplashScreen()
        TabView {
            
           
//            VStack {
//                        Divider()
//                        ScrollView(.horizontal) {
//                            HStack(spacing: 10) {
//                                ForEach(0..<10) { index in
//                                    NewsTab(label: "\(index)")
//                                }
//
//                            }.padding()
//                        }.frame(height: 100)
//                        Divider()
//                        Spacer()
//                    }
           
        
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
