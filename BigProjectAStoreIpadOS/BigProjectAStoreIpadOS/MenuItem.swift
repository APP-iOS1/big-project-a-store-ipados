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
    
}


let menuItems: [MenuItem] = [
    MenuItem(name: "상품 관리"),
    MenuItem(name: "주문 관리"),
    MenuItem(name: "스토어 관리"),
    MenuItem(name: "매출 현황"),
    MenuItem(name: "문의 및 리뷰 관리")
   
]
