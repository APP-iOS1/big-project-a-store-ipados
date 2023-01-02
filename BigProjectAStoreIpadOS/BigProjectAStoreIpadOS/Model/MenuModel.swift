//
//  MenuModel.swift
//  BigProjectAStoreIpadOS
//
//  Created by 최한호 on 2022/12/28.
//

import Foundation
import SwiftUI

// MARK: - 상위 메뉴
struct MenuItem: Identifiable {
    var id = UUID()
    var name: String
    var subMenuItem: [MenuItem]? = nil
    
    @State var selected = selectedMenu.deliveryManagement

    @ViewBuilder
    var body: some View {
        switch selected {
            
        case .productRegister:
            ProductRegisterView()
            
        case .productEdit:
            ProductInventoryView()
            
        case .orderHistory:
            OrderHistoryView()
            
        case .deliveryManagement:
            DeliveryView()
        
        case .storeEdit:
            EditStoreView()
            
        case .storeClose:
            CloseStoreView()
            
        case .salesStatistic:
            ChartDetailView()
            
        case .salesGraph:
            ChartView()
            
        case .questionManagement:
            InquiryView()
            
        case .reviewManagement:
            ReviewView()
        }
    }
    
}

struct MenuModel {
    var menuItems: [MenuItem]
    
    init() {
        menuItems = [
            MenuItem(name: "상품 관리", subMenuItem: [
                MenuItem(name: "상품 등록", selected: .productRegister),
                MenuItem(name: "상품 수정", selected: .productEdit),

            ]),
            MenuItem(name: "주문 관리", subMenuItem: [
                MenuItem(name: "주문 내역", selected: .orderHistory),
                MenuItem(name: "배송 관리", selected: .deliveryManagement)
            ]),
            MenuItem(name: "스토어 관리", subMenuItem: [
                MenuItem(name: "스토어 정보 수정", selected: .storeEdit),
                MenuItem(name: "폐점 신청", selected: .storeClose)
            ]),
            MenuItem(name: "매출현황", subMenuItem: [
                MenuItem(name: "매출 통계", selected: .salesStatistic),
                MenuItem(name: "매출 그래프", selected: .salesGraph)
            ]),
            MenuItem(name: "문의 및 리뷰 관리", subMenuItem: [
                MenuItem(name: "문의 내역", selected: .questionManagement),
                MenuItem(name: "리뷰 내역", selected: .reviewManagement)
            ])
        ]
    }
    
    func menuItem(id: MenuItem.ID?) -> MenuItem? {
        self.menuItems.first(where: { $0.id == id })
    }
    
    func selectedSubMenuItem(selectedSubMenuId: MenuItem.ID?) -> MenuItem? {
        for item in self.menuItems {
            if let temp = item.subMenuItem?.first(where: { $0.id == selectedSubMenuId }) {
                return temp
            }
        }

        return nil
    }
}
