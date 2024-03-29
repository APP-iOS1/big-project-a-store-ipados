//
//  Fundamental.swift
//  BigProjectAStoreIpadOS
//
//  Created by 이승준 on 2022/12/28.
//

import Foundation

typealias SnapshotDataType = [String: Any]

let appCategory: AppCategoryEnum = .store
let csCategory: AppCategoryEnum = .cs
var storeApproveState: StoreApproveState = .needSubmit

// MARK: - 앱의 성격을 구별하는 카테고리 열거형
/// 사용자가 현재 사용 중인 프로젝트의 앱을 구별하는 열거형입니다.
/// - 현재 앱에서는 판매자용 iPad 앱임을 나타내기 위해 전역 상수로 .store 가 할당되어 있습니다.
/// - 해당 열거형의 원시값을 활용하여 Firebase의 콜렉션에 접근합니다.
enum AppCategoryEnum: String, Codable {
	case customer, store = "StoreInfo", backoffice, cs = "CustomerServiceInfo"
}

// MARK: - 앱 전체에서 활용될 StoreInfo
/// 판매자가 회원가입 하거나 로그인할 때 생성될 구조체 입니다.
/// - 해당 구조체의 id는 회원가입 시점에 생성되는 uid를 갖게 됩니다.
/// - 앱에 로그인한 사용자는 자기 자신의 uid로 접근할 수 있는 데이터에 한하여 CRUD를 진행할 수 있습니다.
struct StoreInfo: Codable {
	var storeId: String // 회원가입 시점에 생성되는 uid를 할당합니다.
	var storeEmail: String
	var registerDate: String // Timestamp Extension 메소드로 리턴받은 String을 할당합니다.
	var reportingCount: Int
	var storeImage: String?
	var phoneNumber: String?
	var storeLocation: String?
	var storeName: String?
	var isVerified: Bool = false // 입점 허가 여부
	var isSubmitted: Bool = false
	var isBanned: Bool = false // 신고 누적으로 인한 퇴출 여부
}

// MARK: - Store Approve State
/// Store 유저가 인증 신청을 했는지, 하지 않았는지, 인증 되었는지, 밴 되었는지에 따라 뷰를 분기해줄 열거형 입니다.
enum StoreApproveState {
	case needSubmit, submitted, approved, banned
}

enum StoreInfoUpdateType {
	case storeId(key: String = "storeId", value: String)
	case storeName(key: String = "storeName", value: String)
	case storeEmail(key: String = "storeEmail", value: String)
	case storeLocation(key: String = "storeLocation", value: String)
	case registerDate(key: String = "registerDate", value: Date)
	case reportingCount(key: String = "reportingCount", value: Int)
	case storeImage(key: String = "storeImage", value: [String])
	case phoneNumber(key: String = "phoneNumber", value: String)
	case isVerified(key: String = "isVerified", value: Bool)
	case isSubmitted(key: String = "isSubmitted", value: Bool)
	case isBanned(key: String = "isBanned", value: Bool)
}
