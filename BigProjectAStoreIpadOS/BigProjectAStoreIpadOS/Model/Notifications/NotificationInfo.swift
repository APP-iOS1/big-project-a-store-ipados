//
//  Notification.swift
//  BigProjectAStoreIpadOS
//
//  Created by 이승준 on 2022/12/28.
//

import Foundation

// MARK: - NotificationInfo, 알람 데이터를 생성하는 구조체
/// backoffice에서 수신받을 알람 데이터로 구조체를 생성합니다.
/// - 해당 알람 정보를 판매자가 view에서 열람할 경우, 곧바로 isViewed 프로퍼티를 true로 업데이트 합니다.
struct NotificationInfo: Codable {
	var notificationId: String
	var receiverId: String
	var isViewed: Bool = false
	var notificationDescription: String
	var notificationDate: Date
	var appCategory: AppCategoryEnum = .customer
}
