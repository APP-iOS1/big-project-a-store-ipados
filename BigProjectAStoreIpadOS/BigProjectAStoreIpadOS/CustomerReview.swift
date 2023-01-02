//
//  CustomerReview.swift
//  BigProjectAStoreIpadOS
//
//  Created by Sue on 2023/01/02.
//

import Foundation

struct CustomerReview: Identifiable, Hashable {
    
    let id = UUID()
    let reviewCreatedDate: String // 생성일
    let registrant: String //리뷰 등록한 사람, 등록자
    let registrantID: String //등록자 ID
    let orderNumber: String //주문번호
    let orderProduct: String //상품명
    let orderProductID: String //상품 id
    let reviewContent: String  //리뷰 내용
    let rate: Int //별점
}
