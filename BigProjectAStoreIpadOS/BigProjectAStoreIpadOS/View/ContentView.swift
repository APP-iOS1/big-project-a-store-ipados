//
//  ContentView.swift
//  SplitViewDemo
//
//  Created by 추현호 on 2022/12/27.
//

import SwiftUI

struct ContentView: View {
    @StateObject var navigationStateManager = NavigationStateManager()
    @StateObject var signUpViewModel: SignUpViewModel  = SignUpViewModel()
    @StateObject var storeNetworkManager: StoreNetworkManager = StoreNetworkManager()
    @State private var showSettings = false
    @State private var menuId: MenuItem.ID?
	
    @State var haveStore = false
    @State var isStoreApproved = false

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
                        EditStoreView().environmentObject(storeNetworkManager)
                    case "매출현황":
                        ChartDetailView()
                    case "문의 및 리뷰 관리":
                        InquiryView()
					case "로그아웃":
						SettingsView()
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
            .navigationTitle("ZZIRIT 스토어")
            
			ProductInventoryView()
        }
        .environmentObject(navigationStateManager)
		.environmentObject(authViewModel)
        .navigationSplitViewStyle(.balanced)
        .fullScreenCover(isPresented: $isLoggedin) {
            LoginView(haveStore: $haveStore, isLoggedin: $isLoggedin, isStoreApproved: $isStoreApproved).environmentObject(signUpViewModel)
        }
        .fullScreenCover(isPresented: $haveStore) {
            OpenStoreView(isLoggedin: $isLoggedin, haveStore: $haveStore)
        }
        .fullScreenCover(isPresented: $isStoreApproved) {
            WaitingView(isStoreApproved: $isStoreApproved, isLoggedin: $isLoggedin).environmentObject(signUpViewModel)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
