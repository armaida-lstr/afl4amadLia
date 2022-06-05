//
//  afl4amadLiaApp.swift
//  afl4amadLia
//
//  Created by MacBook Pro on 29/05/22.
//

import SwiftUI

@main
struct afl4amadLiaApp: App {
    @StateObject var articleBookmarkVM = BookmarkVM.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(articleBookmarkVM)
        }
    }
}
