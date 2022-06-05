//
//  BookmarkTab.swift
//  afl4amadLia
//
//  Created by MacBook Pro on 31/05/22.
//

import SwiftUI

struct BookmarkTab: View {
    
    @EnvironmentObject var articleBookmarkVM: BookmarkVM
    @State var searchText: String = ""
    
    var body: some View {
        let articles = self.articles
        
        NavigationView {
            ArticleListView(articles: articles)
                .overlay(overlayView(isEmpty: articles.isEmpty))
                .navigationTitle("Favorites Articles")
        }
        .searchable(text: $searchText)
    }
    
    private var articles: [Article] {
        if searchText.isEmpty {
            return articleBookmarkVM.bookmarks
        }
        return articleBookmarkVM.bookmarks
            .filter {
                $0.title.lowercased().contains(searchText.lowercased()) ||
                $0.descriptionText.lowercased().contains(searchText.lowercased())
            }
    }
    
    @ViewBuilder
    func overlayView(isEmpty: Bool) -> some View {
        if isEmpty {
            SimpanKosong(text: "No saved articles Favorites", image: Image(systemName: "heart.rectangle"))
        }
    }
}

struct BookmarkTab_Previews: PreviewProvider {
    
    @StateObject static var articleBookmarkVM = BookmarkVM.shared

    static var previews: some View {
        BookmarkTab()
            .environmentObject(articleBookmarkVM)
    }
}
