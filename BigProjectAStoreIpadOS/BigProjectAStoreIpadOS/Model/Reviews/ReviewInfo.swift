//
//  ReviewInfo.swift
//  BigProjectAStoreIpadOS
//
//  Created by 이승준 on 2022/12/28.
//

import Foundation

struct ReviewInfo: Codable {
	var id: String = UUID().uuidString
	var postDescription: String
	var postDate: Date
	var reviewerId: String
	var rate: Double
	var orderedItem: [OrderedItemInfo]
}

