//
//  NewsTab.swift
//  afl4amadLia
//
//  Created by MacBook Pro on 31/05/22.
//

import SwiftUI

struct NewsTab: View {
  //  @State var label: String
//    @State var label: String
  
    @StateObject var searchVM = SearchVM.shared
    @StateObject var articleNewsVM = NewsVM()
    
    
    var body: some View {
//        ZStack {
//                   Circle()
//                       .fill(Color.yellow)
//                       .frame(width: 70, height: 70)
//                   Text(label)
//               }
        NavigationView {
            

            
            ArticleListView(articles: articles)
                .overlay(overlayView)
                .task(id: articleNewsVM.fetchTaskToken, loadTask)
                .refreshable(action: refreshTask)
                .navigationTitle(articleNewsVM.fetchTaskToken.kategoriA.text)
                .navigationBarItems(trailing: menu)
//                .navigationTitle("The Sire News")
            

                .navigationTitle("Search")
            
               
            .searchable(text: $searchVM.searchQuery) { suggestionsView }
            .onChange(of: searchVM.searchQuery) { newValue in
            if newValue.isEmpty {
                searchVM.phase = .empty
            }
        }
        .onSubmit(of: .search, search)
            
            
           
            
        }
    }
    
    @ViewBuilder
    private var overlayView: some View {
        
        switch searchVM.phase {
        case .empty:
            if !searchVM.searchQuery.isEmpty {
                ProgressView()
            } else if !searchVM.history.isEmpty {
                SearchHistory(searchVM: searchVM) { newValue in
                    // Need to be handled manually as it doesn't trigger default onSubmit modifier
                    searchVM.searchQuery = newValue
                    search()
                }
//            } else {
//                SimpanKosong(text: "Type your query to search from NewsAPI", image: Image(systemName: "magnifyingglass"))
           }
//
        case .success(let articles) where articles.isEmpty:
            SimpanKosong(text: "No search results found", image: Image(systemName: "magnifyingglass"))
            
        case .failure(let error):
            RetryView(text: error.localizedDescription, retryAction: search)
            
        default: EmptyView()
            
        }
        
        
        
        
        switch articleNewsVM.phase {
        case .empty:
            ProgressView()
        case .success(let articles) where articles.isEmpty:
            SimpanKosong(text: "No Articles", image: nil)
        case .failure(let error):
            RetryView(text: error.localizedDescription, retryAction: refreshTask)
        default: EmptyView()
        }
    }
    
    private var articles: [Article] {
//        switch (articleNewsVM.phase), (searchVM.phase){
        if case let .success(articles) = (articleNewsVM.phase){
            return articles
        }
        if case .success(let articles) = searchVM.phase {
           return articles
        } else {
           return []
       }
    }
    
  
    
    @Sendable
    private func loadTask() async {
        await articleNewsVM.loadArticles()
    }
    
    @Sendable
    private func refreshTask() {
        DispatchQueue.main.async {
            articleNewsVM.fetchTaskToken = FetchTaskToken(kategoriA: articleNewsVM.fetchTaskToken.kategoriA, token: Date())
        }
    }
    
    private var menu: some View {
        Menu {
            Picker("Category", selection: $articleNewsVM.fetchTaskToken.kategoriA) {
                ForEach(KategoriA.allCases) {
                    Text($0.text).tag($0)
                }
            }
        } label: {
            Image(systemName: "checklist")
                .imageScale(.large)
//
//            ZStack {
//                Circle()
//                    .fill(Color.yellow)
//                    .frame(width: 70, height: 70)
//                    .imageScale(.large)
//                Text(label)
//
//
                                 
            
//
        }
    }
    
    
    
    
//    private var art: [Article] {
//        if case .success(let articles) = searchVM.phase {
//           return articles
//        } else {
//            return []
//        }
//    }
    
//    @ViewBuilder
//    private var overL: some View {
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
    
    @ViewBuilder
    private var suggestionsView: some View {
        ForEach(["Apple", "NCT", "BTS", "UNIVERSITAS", "INDONESIA"], id: \.self) { text in
            Button {
                searchVM.searchQuery = text
            } label: {
                Text(text)
            }
        }
    }
    
    private func search() {
        let searchQuery = searchVM.searchQuery.trimmingCharacters(in: .whitespacesAndNewlines)
        if !searchQuery.isEmpty {
            searchVM.addHistory(searchQuery)
        }
        
        Task {
            await searchVM.searchArticle()
        }
    }
}

struct NewsTab_Previews: PreviewProvider {
    
    @StateObject static var articleBookmarkVM = BookmarkVM.shared
    
    @StateObject static var bookmarkVM = BookmarkVM.shared

    
    static var previews: some View {
        NewsTab(articleNewsVM: NewsVM(articles: Article.previewData))
            .environmentObject(articleBookmarkVM)
            .environmentObject(bookmarkVM)
    }
}
