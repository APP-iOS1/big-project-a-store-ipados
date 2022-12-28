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
    var subMenuItem: [SubMenuItem]
    
    init(name: String, subMenuItem: [SubMenuItem]) {
        self.name = name
        self.subMenuItem = subMenuItem
    }
}

// MARK: - 서브 메뉴 이름
struct SubMenuItem: Identifiable {
    var id = UUID()
    var name: String
    
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
            EditStoreView()
            
        case .salesStatistic:
            ChartView()
            
        case .salesGraph:
            ChartView()
            
        case .questionManagement:
            InquiryView()
            
        case .reviewManagement:
            InquiryView()
        }
    }
}




struct MenuModel {
    var menuItems: [MenuItem]
    
    init() {
        menuItems = [
            MenuItem(name: "상품 관리", subMenuItem: [
                SubMenuItem(name: "상품 등록", selected: .productRegister),
                SubMenuItem(name: "상품 수정", selected: .productEdit)
            ]),
            MenuItem(name: "주문 관리", subMenuItem: [
                SubMenuItem(name: "주문 내역", selected: .orderHistory),
                SubMenuItem(name: "배송 관리", selected: .deliveryManagement)
            ]),
            MenuItem(name: "스토어 관리", subMenuItem: [
                SubMenuItem(name: "스토어 정보 수정", selected: .storeEdit),
                SubMenuItem(name: "폐점 신청", selected: .storeClose)
            ]),
            MenuItem(name: "매출현황", subMenuItem: [
                SubMenuItem(name: "매출 통계", selected: .salesStatistic),
                SubMenuItem(name: "매출 그래프", selected: .salesGraph)
            ]),
            MenuItem(name: "문의 및 리뷰 관리", subMenuItem: [
                SubMenuItem(name: "문의 내역", selected: .questionManagement),
                SubMenuItem(name: "리뷰 내역", selected: .reviewManagement)
            ])
        ]
    }
    
    func menuItem(id: MenuItem.ID?) -> MenuItem? {
        self.menuItems.first(where: { $0.id == id })
    }
    
    func selectedSubMenuItem(selectedSubMenuId: SubMenuItem.ID?) -> SubMenuItem? {
        for item in self.menuItems {
            if let temp = item.subMenuItem.first(where: { $0.id == selectedSubMenuId }) {
                return temp
            }
        }
        
        return nil
    }
}
