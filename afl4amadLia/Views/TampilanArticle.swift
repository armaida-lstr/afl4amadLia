//
//  TampilanArticle.swift
//  afl4amadLia
//
//  Created by MacBook Pro on 29/05/22.
//

import SwiftUI

struct TampilanArticle: View {
    
    @EnvironmentObject var articleBookmarkVM: BookmarkVM
    
    let article: Article
    var body: some View {
        VStack(alignment: .trailing, spacing: 16) {
            AsyncImage(url: article.imageURL) { phase in
           
                switch phase {
                case .empty:
                    HStack {
                        Spacer()
                        ProgressView()
                        Spacer()
                    }

                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)

                case .failure:
                    HStack {
                        Spacer()
                        Image(systemName: "photo")
                            .imageScale(.large)
                        Spacer()
                    }


                @unknown default:
                    fatalError()
                }
            }
            .frame(minHeight: 200, maxHeight: 300)
            .background(Color.gray.opacity(0.3))
            .clipped()

            VStack(alignment: .leading, spacing: 8) {
                Text(article.title)
                    .font(.headline)
                    .lineLimit(3)

                Text(article.descriptionText)
                    .font(.subheadline)
                    .lineLimit(2)

                HStack {
                    Text(article.captionText)
                        .lineLimit(1)
                        .foregroundColor(.secondary)
                        .font(.caption)

                    Spacer()

                    Button {
                        toggleBookmark(for: article)
                    } label: {
                        Image(systemName: articleBookmarkVM.isBookmarked(for: article) ? "heart.fill" : "heart")
                    }
                    .buttonStyle(.bordered)

                    Button {
                        presentShareSheet(url: article.articleURL)
                    } label: {
                        Image(systemName: "square.and.arrow.up.on.square")
                    }
                    .buttonStyle(.bordered)
                }
            }
            .padding([.horizontal, .bottom])
            
        }
    }
    
    private func toggleBookmark(for article: Article) {
        if articleBookmarkVM.isBookmarked(for: article) {
            articleBookmarkVM.removeBookmark(for: article)
        } else {
            articleBookmarkVM.addBookmark(for: article)
        }
    }
}

extension View {
    
    func presentShareSheet(url: URL) {
        let activityVC = UIActivityViewController(activityItems: [url], applicationActivities: nil)
        (UIApplication.shared.connectedScenes.first as? UIWindowScene)?
            .keyWindow?
            .rootViewController?
            .present(activityVC, animated: true)
    }
    
}

struct TampilanArticle_Previews: PreviewProvider {
    
    @StateObject static var articleBookmarkVM = BookmarkVM.shared

    static var previews: some View {
        NavigationView {
            List {
                TampilanArticle(article: .previewData[0])
                    .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
            }
            .listStyle(.plain)
        }
        .environmentObject(articleBookmarkVM)
    }
}
