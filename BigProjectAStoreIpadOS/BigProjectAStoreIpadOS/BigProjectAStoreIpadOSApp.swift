//
//  BigProjectAStoreIpadOSApp.swift
//  BigProjectAStoreIpadOS
//
//  Created by Sue on 2022/12/27.
//

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        
        return true
    }
}

@main
struct BigProjectAStoreIpadOSApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject var storeNetworkManager = StoreNetworkManager()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(storeNetworkManager)
        }
    }
}

