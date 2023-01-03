//
//  ItemInfo.swift
//  BigProjectAStoreIpadOS
//
//  Created by 이승준 on 2022/12/28.
//

import Foundation

struct ItemInfo: Codable, Identifiable {
	var id: String {
		self.itemUid
	}
	var itemUid: String
	var storeId: String
	var itemName: String
	var itemCategory: String
//	var itemAmount: Int
	var itemAllOption: ItemOptions
	var itemImage: [String]
	var price: Double
}

// MARK: - ItemOptions 커스텀 타입
/// 판매자가 아이템의 옵션을 직접 추가할 수 있도록 준비된 커스텀 타입입니다.
/// 사용자가 좌측에 입력한 키(key)가 Firebase 문서에 없다면, 자동으로 해당 데이터를 업데이트 합니다.
/// 모든 키의 밸류(value)는 배열로 업데이트 됩니다.
struct ItemOptions: Codable {
	var itemOptions: [String: [String]]
}

struct OrderInfo: Codable {
	var orderId: String = UUID().uuidString
	var orderedUserInfo: String
	var orderTime: Double
	var orderedItems: [OrderedItemInfo]
	var orderAddress: String
	var orderMessage: String?
	var payment: PaymentEnum = .byCreditCard
}

struct OrderedItemInfo: Codable {
	var itemUid: String
	var itemName: String
	var itemImage: [String]
	var price: Double
	var option: ItemOptions
	var deliveryStatus: DeliveryStatusEnum = .pending
}

enum DeliveryStatusEnum: String, Codable {
	case pending = "배송준비중", onDeliverying = "배송중", didDelieveried = "배송완료"
}

enum PaymentEnum: String, Codable {
	case byCreditCard = "카드결제", byAccount = "무통장입금", byMobile = "핸드폰결제"
}
