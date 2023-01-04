//
//  InquiryModel.swift
//  BigProjectAStoreIpadOS
//
//  Created by 추현호 on 2023/01/04.
//

import Foundation
import Firebase

typealias ItemAllOption = [String:[String]]?

// MARK: - 고객 서비스를 위한 모델
/// 제품 문의 기능에서 사용하는 데이터 모델입니다.
struct CustomerServiceInfo: Identifiable, Hashable {
    var id: String
    var title: String           // 문의 제목
    var description: String     // 문의 내역
    var itemId: String          // 문의를 하려는 제품 id
    var itemName: String        // 문의를 하려는 제품명
    var itemImage: [String]     // 문의를 하려는 제품의 이미지(배열)
    var serviceDate: Timestamp       // 문의 날짜
    var customerId: String      // 작성자
    var orderId: String         // 주문번호
    var itemAllOption: ItemAllOption?   // 선택한 제품 옵션
    var isAnswered: Bool = false // 판매자 답글 여부
    
    var formattedServiceDate: String {
        get {
            serviceDate.formattedKoreanTime()
        }
    }
    
    var isAnsweredInt: Int {
        isAnswered ? 0 : 1
    }
}
