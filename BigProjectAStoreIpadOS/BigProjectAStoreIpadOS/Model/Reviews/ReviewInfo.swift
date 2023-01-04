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
	var reviewerId: String // 등록자 아이디
	var postDescription: String // 리뷰 내용
	var postDate: String // 리뷰 등록일
	var rate: Int //구매자 평점
	var orderedItem: [OrderedItemInfo] // 등록자 구매한 물품
}

