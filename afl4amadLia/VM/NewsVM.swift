//
//  NewsVM.swift
//  afl4amadLia
//
//  Created by MacBook Pro on 29/05/22.
//

import SwiftUI

enum DataFetchPhase<T> {
    
    case empty
    case success(T)
    case failure(Error)
}

struct FetchTaskToken: Equatable {
    var kategoriA: KategoriA
    var token: Date
}

@MainActor
class NewsVM: ObservableObject {
    //search
    @Published var phase: DataFetchPhase<[Article]> = .empty
    @Published var searchQuery = ""
 //   @Published var history = [String]()
    
  //  private let historyDataStore = PlistDataStore<[String]>(filename: "histories")
  //  private let historyMaxLimit = 10
    
   // private let newsAPI = API.shared
    
    //article
   // @Published var phase = DataFetchPhase<[Article]>.empty
    @Published var fetchTaskToken: FetchTaskToken
    private let newsAPI = API.shared
    private var trimmedSearchQuery: String {
        searchQuery.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    static let shared = NewsVM()
//
//    private init() {
//        self.load()
//    }
    
    //search
//    func addHistory(_ text: String) {
//        if let index = history.firstIndex(where: { text.lowercased() == $0.lowercased() }) {
//            history.remove(at: index)
//        } else if history.count == historyMaxLimit {
//            history.remove(at: history.count - 1)
//        }
//
//        history.insert(text, at: 0)
//        historiesUpdated()
//    }
//
//    func removeHistory(_ text: String) {
//        guard let index = history.firstIndex(where: { text.lowercased() == $0.lowercased() }) else {
//            return
//        }
//        history.remove(at: index)
//        historiesUpdated()
//    }
//
//    func removeAllHistory() {
//        history.removeAll()
//        historiesUpdated()
//    }
    
    func searchArticle() async {
        if Task.isCancelled { return }
        
        let searchQuery = trimmedSearchQuery
        phase = .empty
        
        if searchQuery.isEmpty {
            return
        }
        
        do {
            let articles = try await newsAPI.search(for: searchQuery)
            if Task.isCancelled { return }
            if searchQuery != trimmedSearchQuery {
                return
            }
            phase = .success(articles)
        } catch {
            if Task.isCancelled { return }
            if searchQuery != trimmedSearchQuery {
                return
            }
            phase = .failure(error)
        }
    }
    
//    private func load() {
//        Task {
//            self.history = await historyDataStore.load() ?? []
//        }
//    }
    
//    private func historiesUpdated() {
//        let history = self.history
//        Task {
//            await historyDataStore.save(history)
//        }
//    }
//
    
    
    
    
    init(articles: [Article]? = nil, selectedCategory: KategoriA = .general) {
        if let articles = articles {
            self.phase = .success(articles)
        } else {
            self.phase = .empty
        }
        self.fetchTaskToken = FetchTaskToken(kategoriA: selectedCategory, token: Date())
    }
    
    func loadArticles() async {
        if Task.isCancelled { return }
        phase = .empty
        do {
            let articles = try await newsAPI.fetch(from: fetchTaskToken.kategoriA)
            if Task.isCancelled { return }
            phase = .success(articles)
        } catch {
            if Task.isCancelled { return }
            print(error.localizedDescription)
            phase = .failure(error)
        }
    }
}
