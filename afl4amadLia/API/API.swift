//
//  afl4amadLia
//
//  Created by MacBook Pro on 25/05/22.
//


import Foundation

struct API {
    
    static let shared = API()
    private init() {}
    
    private let apiKey = "41855beebf3449a99669da4062946153"
    private let session = URLSession.shared
    private let jsonDecoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }()
    
    func fetch(from kategoriA: KategoriA) async throws -> [Article] {
        try await fetchArticles(from: generateNewsURL(from: kategoriA))
    }
    
    func search(for query: String) async throws -> [Article] {
        try await fetchArticles(from: generateSearchURL(from: query))
    }
    
    private func fetchArticles(from url: URL) async throws -> [Article] {
        let (data, response) = try await session.data(from: url)
        
        guard let response = response as? HTTPURLResponse else {
            throw generateError(description: "Bad Response")
        }
        
        switch response.statusCode {
            
        case (200...299), (400...499):
            let apiResponse = try jsonDecoder.decode(APIResponse.self, from: data)
            if apiResponse.status == "ok" {
                return apiResponse.articles ?? []
            } else {
                throw generateError(description: apiResponse.message ?? "An Error Occured")
            }
        default:
            throw generateError(description: "server error")
        }
    }
    
    private func generateError(code: Int = 1, description: String) -> Error {
        NSError(domain: "API", code: code, userInfo: [NSLocalizedDescriptionKey: description])
    }
    
    private func generateSearchURL(from query: String) -> URL {
        let percentEncodedString = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? query
        var url = "https://newsapi.org/v2/top-headlines?"
        url += "apiKey=\(apiKey)"
        url += "&language=en"
        url += "&q=\(percentEncodedString)"
        return URL(string: url)!
    }
    
    private func generateNewsURL(from kategoriA: KategoriA) -> URL {
        var url = "https://newsapi.org/v2/top-headlines?"
        url += "apiKey=\(apiKey)"
        url += "&language=en"
        url += "&kategoriA=\(kategoriA.rawValue)"
        return URL(string: url)!
    }
}
//static let topHeadlinesURL = URL(string: "https://newsapi.org/v2/everything?q=bitcoin&apiKey=41855beebf3449a99669da4062946153")
//static let searchurl = "https://newsapi.org/v2/everything?sortBy=popularity&apiKey=41855beebf3449a99669da4062946153&q="
//}
