//
//  Product.swift
//  BigProjectAStoreIpadOS
//
//  Created by 추현호 on 2022/12/27.
//

import SwiftUI

struct ProductData: Identifiable, Hashable{
    var id = UUID()
    var productName: String
    var productId: String
    var productCategory: String
    var productCount: Int
}

var sampleData:[ProductData] = [
    ProductData(productName: "키보드", productId: "psdfsdfsdfsdf1", productCategory: "키보드", productCount: 21),
    ProductData(productName: "마우스", productId: "p2", productCategory: "마우스", productCount: 34),
    ProductData(productName: "컴퓨터", productId: "p3", productCategory: "데스크탑", productCount: 56),
    ProductData(productName: "노트북", productId: "p8", productCategory: "랩탑", productCount: 86),
    ProductData(productName: "맥북", productId: "p9", productCategory: "랩탑", productCount: 92),
    ProductData(productName: "애플워치", productId: "p11", productCategory: "전자시계", productCount: 143),
    ProductData(productName: "아이패드", productId: "p12", productCategory: "테블릿", productCount: 95),
    ProductData(productName: "갤탭", productId: "p13", productCategory: "테블릿", productCount: 23)
    
]
