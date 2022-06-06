//
//  NewsTab.swift
//  afl4amadLia
//
//  Created by MacBook Pro on 31/05/22.
//

import SwiftUI

struct NewsTab: View {
 
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
            
               
            .searchable(text: $articleNewsVM.searchQuery) 
            .onChange(of: articleNewsVM.searchQuery) { newValue in
            if newValue.isEmpty {
                articleNewsVM.phase = .empty
            }
        }
        .onSubmit(of: .search, search)
            
            
           
            
        }
    }
    
    @ViewBuilder
    private var overlayView: some View {

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
         else {
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
    
 
    private func search() {
        let searchQuery = articleNewsVM.searchQuery.trimmingCharacters(in: .whitespacesAndNewlines)
        if !searchQuery.isEmpty {
//            articleNewsVM.addHistory(searchQuery)
            articleNewsVM.searchQuery.trimmingCharacters(in: .whitespacesAndNewlines)
        }
        
        Task {
            await articleNewsVM.searchArticle()
        }
    }
}

struct NewsTab_Previews: PreviewProvider {
    
    @StateObject static var articleBookmarkVM = BookmarkVM.shared
    
    static var previews: some View {
        NewsTab(articleNewsVM: NewsVM(articles: Article.previewData))
            .environmentObject(articleBookmarkVM)
//            .environmentObject(bookmarkVM)
   }
}
