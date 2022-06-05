////
////  SearchTab.swift
////  afl4amadLia
////
////  Created by MacBook Pro on 31/05/22.
////
//import SwiftUI
//
//struct SearchTab: View {
//    
//    @StateObject var searchVM = SearchVM.shared
//    
//    var body: some View {
//        NavigationView {
//            ArticleListView(articles: articles)
//                .overlay(overlayView)
//                .navigationTitle("Search")
//        }
//        .searchable(text: $searchVM.searchQuery) { suggestionsView }
//        .onChange(of: searchVM.searchQuery) { newValue in
//            if newValue.isEmpty {
//                searchVM.phase = .empty
//            }
//        }
//        .onSubmit(of: .search, search)
//    }
//    
//    private var articles: [Article] {
//        if case .success(let articles) = searchVM.phase {
//           return articles
//        } else {
//            return []
//        }
//    }
//    
//    @ViewBuilder
//    private var overlayView: some View {
//        switch searchVM.phase {
//        case .empty:
//            if !searchVM.searchQuery.isEmpty {
//                ProgressView()
//            } else if !searchVM.history.isEmpty {
//                SearchHistory(searchVM: searchVM) { newValue in
//                    // Need to be handled manually as it doesn't trigger default onSubmit modifier
//                    searchVM.searchQuery = newValue
//                    search()
//                }
//            } else {
//                SimpanKosong(text: "Type your query to search from NewsAPI", image: Image(systemName: "magnifyingglass"))
//            }
//            
//        case .success(let articles) where articles.isEmpty:
//            SimpanKosong(text: "No search results found", image: Image(systemName: "magnifyingglass"))
//            
//        case .failure(let error):
//            RetryView(text: error.localizedDescription, retryAction: search)
//            
//        default: EmptyView()
//            
//        }
//    }
//    
//    @ViewBuilder
//    private var suggestionsView: some View {
//        ForEach(["Apple", "NCT", "BTS", "UNIVERSITAS", "INDONESIA"], id: \.self) { text in
//            Button {
//                searchVM.searchQuery = text
//            } label: {
//                Text(text)
//            }
//        }
//    }
//    
//    private func search() {
//        let searchQuery = searchVM.searchQuery.trimmingCharacters(in: .whitespacesAndNewlines)
//        if !searchQuery.isEmpty {
//            searchVM.addHistory(searchQuery)
//        }
//        
//        Task {
//            await searchVM.searchArticle()
//        }
//    }
//}
//
//struct SearchTab_Previews: PreviewProvider {
//    
//    @StateObject static var bookmarkVM = BookmarkVM.shared
//    
//    static var previews: some View {
//        SearchTab()
//            .environmentObject(bookmarkVM)
//    }
//}
