//
//  SearchHistory.swift
//  afl4amadLia
//
//  Created by MacBook Pro on 29/05/22.
//

import SwiftUI

struct SearchHistory: View {
    
    @ObservedObject var searchVM: SearchVM
    let onSubmit: (String) -> ()
    
    var body: some View {
        List {
            HStack {
                Text("Recently Searched")
                Spacer()
                Button("Clear") {
                    searchVM.removeAllHistory()
                }
                .foregroundColor(.accentColor)
            }
            .listRowSeparator(.hidden)
            
            ForEach(searchVM.history, id: \.self) { history in
                Button(history) {
                    onSubmit(history)
                }
                .swipeActions {
                    Button(role: .destructive) {
                        searchVM.removeHistory(history)
                    } label: {
                        Label("Delete", systemImage: "trash.circle")
                    }
                }
            }
        }
        .listStyle(.plain)
    }
}

struct SearchHistory_Previews: PreviewProvider {
    static var previews: some View {
        SearchHistory(searchVM: SearchVM.shared) { _ in
            
        }
    }
}
