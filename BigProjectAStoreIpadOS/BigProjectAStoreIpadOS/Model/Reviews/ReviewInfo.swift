//
//  ReviewInfo.swift
//  BigProjectAStoreIpadOS
//
//  Created by 이승준 on 2022/12/28.
//

import Foundation

struct ReviewInfo: Codable {
	var reviewPostId: String
	var itemId: String
	var storeId: String
	var reviewerId: String
	var postDescription: String
	var postDate: String
	var rate: Int
	var orderedItem: [OrderedItemInfo]
}

