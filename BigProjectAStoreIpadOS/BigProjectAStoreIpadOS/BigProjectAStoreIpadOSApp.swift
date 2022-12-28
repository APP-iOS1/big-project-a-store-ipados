//
//  BigProjectAStoreIpadOSApp.swift
//  BigProjectAStoreIpadOS
//
//  Created by Sue on 2022/12/27.
//

import SwiftUI

@main
struct BigProjectAStoreIpadOSApp: App {
    @State var isShownFullScreenCover = true
    
    var body: some Scene {
        WindowGroup {
                ContentView()
                .fullScreenCover(isPresented: $isShownFullScreenCover) {
                    LoginView(isShownFullScreenCover: $isShownFullScreenCover)
                }
        }
    }
}
