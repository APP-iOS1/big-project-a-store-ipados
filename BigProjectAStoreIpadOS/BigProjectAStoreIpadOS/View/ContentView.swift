//
//  ContentView.swift
//  SplitViewDemo
//
//  Created by 추현호 on 2022/12/27.
//

import SwiftUI

struct ContentView: View {
    
    @State private var showSettings = false
    
    @State private var menuId: MenuItem.ID?
    @State private var subMenuId: SubMenuItem.ID?
    
    @ViewBuilder
    fileprivate func SubMenuDetails(for subMenuId: SubMenuItem.ID?) -> some View {
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
        NavigationSplitView() {
            List(model.menuItems, selection: $menuId) { menu in
                Text(menu.name)
            }
            .toolbar(content: {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showSettings.toggle()
                    } label: {
                        Image(systemName: "gearshape")
                    }
                }
            })
            .sheet(isPresented: $showSettings, content: {
              SettingsView()
            })
            .navigationTitle("멋사 전자")
        } content: {
            if let menu = model.menuItem(id: menuId) {
                List(menu.subMenuItem, selection: $subMenuId) { subMenu in
                    Text(subMenu.name)
                }
            } else {
                Text("메뉴를 선택해주세요")
            }
        } detail: {
            SubMenuDetails(for: subMenuId)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
