//
//  NavigationStateManager.swift
//  BigProjectAStoreIpadOS
//
//  Created by 최한호 on 2022/12/28.
//

import SwiftUI
import Combine

class NavigationStateManager: ObservableObject {
    
    @Published var columnVisibility: NavigationSplitViewVisibility = .all
    
    
    func goToSettings() {
        
    }
}
