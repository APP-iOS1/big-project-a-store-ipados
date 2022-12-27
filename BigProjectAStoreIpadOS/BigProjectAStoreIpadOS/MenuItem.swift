//
//  MenuItem.swift
//  BigProjectAStoreIpadOS
//
//  Created by Sue on 2022/12/27.
//

import Foundation

struct MenuItem: Identifiable, Hashable {
    var id = UUID()
    var name: String
    var subMenuItems: [MenuItem]?
}

struct MenuModel {
    
    let totalMenuItems = {

        let productManageItems = [MenuItem(name: "상품 등록"),
                                  MenuItem(name: "상품 수정")]
        
        let orderManageItems = [MenuItem(name: "주문내역"),
                                MenuItem(name: "배송 관리")]
        
        let storeManageItems = [MenuItem(name: "스토어 정보 수정"),
                                MenuItem(name: "폐점 신청")]
        
        let inquiryReviewItems = [MenuItem(name: "문의 내역"),
                                  MenuItem(name: "리뷰 내역")]
        
        
        let menuItems = [
            MenuItem(name: "상품 관리", subMenuItems: productManageItems),
            MenuItem(name: "주문 관리", subMenuItems: orderManageItems),
            MenuItem(name: "스토어 관리", subMenuItems: storeManageItems),
            MenuItem(name: "매출 현황"),
            MenuItem(name: "문의 및 리뷰 관리", subMenuItems: productManageItems)
        ]
        

        
        return menuItems
    }()
    
    func subMenuItems(for id: MenuItem.ID) -> [MenuItem]? {
        guard let menuItem = totalMenuItems.first(where: { $0.id == id }) else {
            return nil
        }
 
        return menuItem.subMenuItems
    }
 
    func menuItem(for categoryID: MenuItem.ID, itemID: MenuItem.ID) -> MenuItem? {
 
        guard let subMenuItems = subMenuItems(for: categoryID) else {
            return nil
        }
 
        guard let menuItem = subMenuItems.first(where: { $0.id == itemID }) else {
            return nil
        }
 
        return menuItem
    }
}


