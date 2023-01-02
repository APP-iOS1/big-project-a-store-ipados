//
//  ContentView.swift
//  SplitViewDemo
//
//  Created by 추현호 on 2022/12/27.
//

import SwiftUI

struct ContentView: View {
    @StateObject var navigationStateManager = NavigationStateManager()
    @State private var showSettings = false
    @State private var menuId: MenuItem.ID?
    @ViewBuilder
    fileprivate func SubMenuDetails(for subMenuId: MenuItem.ID?) -> some View {
        VStack {
            if let subMenu = model.selectedSubMenuItem(selectedSubMenuId: subMenuId) {
                subMenu.body
            } else {
                Text("세부 메뉴를 선택해주세요")
            }
        }
    }
    
    fileprivate var model = MenuModel()
    
    var body: some View {
        NavigationView {
            Form {
                OutlineGroup(self.model.menuItems, children: \.subMenuItem) { item in
                    NavigationLink {
                        SubMenuDetails(for: item.id)
                    } label: {
                        Text(item.name)
                    }

                }
            }
        }
        .environmentObject(navigationStateManager)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
