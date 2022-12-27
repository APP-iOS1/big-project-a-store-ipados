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
    var productPrice: String
    var productCount: Int
}

var sampleData:[ProductData] = [
    ProductData(productName: "키보드", productId: "psdfsdfsdfsdf1", productPrice: "red", productCount: 21),
    ProductData(productName: "마우스", productId: "p2", productPrice: "blue", productCount: 34),
    ProductData(productName: "컴퓨터", productId: "p3", productPrice: "green", productCount: 56),
    ProductData(productName: "노트북", productId: "p8", productPrice: "yello", productCount: 86),
    ProductData(productName: "맥북", productId: "p9", productPrice: "gray", productCount: 92),
    ProductData(productName: "애플워치", productId: "p11", productPrice: "indigo", productCount: 143),
    ProductData(productName: "아이패드", productId: "p12", productPrice: "white", productCount: 95),
    ProductData(productName: "갤탭", productId: "p13", productPrice: "pink", productCount: 23)
    
]
