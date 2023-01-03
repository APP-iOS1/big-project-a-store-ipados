//
//  ItemInfo.swift
//  BigProjectAStoreIpadOS
//
//  Created by 이승준 on 2022/12/28.
//

import Foundation

struct ItemInfo: Codable {
	var itemUid: String
	var storeId: String
	var itemName: String
	var itemCategory: String
//	var itemAmount: Int
	var itemAllOption: ItemOptions
	var itemImage: [String]
	var price: Double
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
	var price: Double
	var selectedOption: ItemOptions
	var deliveryStatus: DeliveryStatusEnum = .pending
}

enum DeliveryStatusEnum: String, Codable {
	case pending = "배송준비중", onDeliverying = "배송중", didDelieveried = "배송완료"
}

enum PaymentEnum: String, Codable {
	case byCreditCard = "카드결제", byAccount = "무통장입금", byMobile = "핸드폰결제"
}
