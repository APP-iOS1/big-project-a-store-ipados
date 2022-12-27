//
//  ContentView.swift
//  BigProjectAStoreIpadOS
//
//  Created by Sue on 2022/12/27.
//

import SwiftUI

struct ContentView: View {
    //전체메뉴(totalMenu)의 id
    @State private var selectedCategoryId: MenuItem.ID?
    //선택된 메뉴 아이템
    @State private var selectedItem: MenuItem?
    
    
    private var menuModel = MenuModel()
    
    
    
    var body: some View {
        
        // 전체 메뉴 -> content: 서브 메뉴 -> detail: 뷰
        NavigationSplitView {
            List(menuModel.totalMenuItems, selection: $selectedCategoryId) { item in
                Text(item.name)
            }
            .navigationTitle("스토어 관리")
            
        } content: {
            if let selectedCategoryId,
               let subMenuItems = menuModel.subMenuItems(for: selectedCategoryId) {
                
                List(subMenuItems) { item in
                    Text(item.name)
                }
                .listStyle(.plain)
                .navigationBarTitleDisplayMode(.inline)
                
            } else {
                Text("Please select a category")
            }
        } detail: {
            if let selectedItem {
                //
            } else {
                Text("Please select an item")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
