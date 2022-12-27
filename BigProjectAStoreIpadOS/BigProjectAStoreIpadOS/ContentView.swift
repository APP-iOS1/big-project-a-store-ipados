//
//  ContentView.swift
//  BigProjectAStoreIpadOS
//
//  Created by Sue on 2022/12/27.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedMenuItemID: MenuItem.ID?

    
    
    var body: some View {
        NavigationSplitView {
            List(menuItems, selection: $selectedMenuItemID) { menuItem in
                Text(menuItem.name)
            }
        } content: {
            DetailTestView()
        } detail: {
            OrderHistory()
        }
    
        
    }//body
}

struct DetailTestView: View {
    var body: some View {
        Text("DetailView")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
