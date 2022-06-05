//
//  TampilanSafari.swift
//  afl4amadLia
//
//  Created by MacBook Pro on 29/05/22.
//


import SwiftUI
import SafariServices

struct TampilanSafari: UIViewControllerRepresentable {
    
    let url: URL
    
    func makeUIViewController(context: Context) -> some SFSafariViewController {
        SFSafariViewController(url: url)
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}
    
}
