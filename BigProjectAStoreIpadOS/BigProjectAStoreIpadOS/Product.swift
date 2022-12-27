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
    var productCount: String
}

var sampleData:[ProductData] = [
    ProductData(productName: "키보드", productId: "p1", productPrice: "fnn", productCount: "pc1"),
    ProductData(productName: "마우스", productId: "p2", productPrice: "bv", productCount: "pc2"),
    ProductData(productName: "컴퓨터", productId: "p3", productPrice: "y45", productCount: "pc3"),
    ProductData(productName: "노트북", productId: "p8", productPrice: "656", productCount: "pc4"),
    ProductData(productName: "맥북", productId: "p9", productPrice: "234", productCount: "pc5"),
    ProductData(productName: "애플워치", productId: "p11", productPrice: "767", productCount: "pc6"),
    ProductData(productName: "아이패드", productId: "p12", productPrice: "545", productCount: "pc7"),
    ProductData(productName: "갤탭", productId: "p13", productPrice: "332", productCount: "pc8")
    
]
