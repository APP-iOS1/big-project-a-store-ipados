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
    
    @State private var haveStore = false
    @State private var isLoggedin = true
    @State private var isStoreApproved = false

    @ViewBuilder
    fileprivate func SubMenuDetails(for subMenuId: MenuItem.ID?) -> some View {
        VStack {
            if let subMenu = model.selectedSubMenuItem(selectedSubMenuId: subMenuId) {
                subMenu.body
            } else {
                if let mainMenu = model.menuItem(id: subMenuId) {
                    switch mainMenu.name {
                    case "상품 관리":
                        ProductInventoryView()
                    case "주문 관리":
                        OrderHistoryView()
                    case "스토어 관리":
                        EditStoreView()
                    case "매출현황":
                        ChartDetailView()
                    case "문의 및 리뷰 관리":
                        InquiryView()
                    default:
                        ProductInventoryView()
                    }
                }
            }
        }
    }
    
    fileprivate var model = MenuModel()
    
    var body: some View {
        NavigationView {
            Form {
                OutlineGroup(self.model.menuItems, children: \.subMenuItem) { item in
//                    NavigationLink {
//                        SubMenuDetails(for: item.id)
//                    } label: {
//                        Text(item.name)
//                    }
                    Text(item.name)
                        .overlay(NavigationLink(destination: SubMenuDetails(for: item.id), label: {
                            Text("")
                        }))
                }
            }
            .navigationTitle("멋사 전자")
            ProductInventoryView()
        }
        .environmentObject(navigationStateManager)
        .navigationSplitViewStyle(.balanced)
        .fullScreenCover(isPresented: $isLoggedin) {
            LoginView(haveStore: $haveStore, isLoggedin: $isLoggedin)
        }
        .fullScreenCover(isPresented: $haveStore) {
            OpenStoreView(haveStore: $haveStore)
        }
        .fullScreenCover(isPresented: $isStoreApproved) {
            WaitingView(isStoreApproved: $isStoreApproved)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
