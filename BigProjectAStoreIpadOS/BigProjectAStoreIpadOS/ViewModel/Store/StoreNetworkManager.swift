//
//  StoreNetworkManager.swift
//  BigProjectAStoreIpadOS
//
//  Created by 이승준 on 2022/12/28.
//

import SwiftUI
import FirebaseFirestore

import SwiftUI

// MARK: - StoreNetworkManager
/// Store의 데이터를 CRUD 할 수 있는 메소드를 포함하는 클래스 객체 입니다.
/// Publish가 필요한 뷰 데이터를 요청하면 따로 설정이 가능하니, 이승준을 호출해 주세요.
/// 메소드 이름은 Team A 코딩 컨벤션을 따릅니다.
/// - 구현 중 : Request
/// - 구현 예정 : Create
final class StoreNetworkManager: ObservableObject {
	/// 앱이 실행되면서 사용될 "현재 로그인 중인 StoreUser"의 정보를 저장하는 publish 변수 입니다.
	@Published var currentStoreUserInfo: StoreInfo? = nil
	
	let appCategory: String
	let path = Firestore.firestore()
	
	// MARK: Lifecycle
	init(withCategory appCategory: AppCategoryEnum) {
		self.appCategory = appCategory.rawValue
	}
	
	// MARK: - Methos
	// MARK: - Request
	/// 현재 접속 중인 사용자의 uid를 활용하여 뷰를 그릴 때 필요한 데이터를 가져오는 기반 코드 입니다.
	/// - 파라미터로 Auth.auth().currentUser.uid 를 할당합니다.
	/// - 리턴값은 없으며, vm의 currentStoreUserInfo 퍼블리싱 변수에 decoding한 데이터를 저장합니다.
	@MainActor
	public func requestStoreInfo(with currentStoreUserUid: String?) async -> Void {
		guard let currentStoreUserUid else { return }
		let storeUserCollectionPath = path.collection("\(currentStoreUserUid)")
		do {
			let snapshot = try await storeUserCollectionPath.getDocuments()
			
			/// check if the snapshot is empty or not
			/// if he/she has more than one doc, then start fetching
			if snapshot.count == 0 {
				dump("DEBUG: Store User Has No Documents, STOP REQUESTING")
				return
			} else {
				for document in snapshot.documents {
					let requestedData = document.data()
					self.currentStoreUserInfo = makeCurrentStoreUser(with: requestedData)
				}
			}
		} catch {
			dump("\(#function) - DEBUG: REQUEST FAILED")
		}
		
	}
	
	// MARK: - Make CurrentStoreUserInfo
	/// 뷰 모델이 보관하게 될 현재 로그인 한 스토어 유저의 정보를 생성합니다.
	/// Request 메소드의 내부에서 호출됩니다.
	private func makeCurrentStoreUser(with requestedData: SnapshotDataType) -> StoreInfo {
		let storeId: String = requestedData["storeId"] as? String ?? ""
		let storeName: String = requestedData["storeName"] as? String ?? ""
		let storeEmail: String = requestedData["storeEmail"] as? String ?? ""
		let storeLocation: String = requestedData["storeLocation"] as? String ?? ""
		let registerDate: Timestamp = requestedData["registerDate"] as? Timestamp ?? Timestamp(date: Date.now)
		let reportingCount: Int = requestedData["reportingCount"] as? Int ?? 0
		let phoneNumber: String = requestedData["phoneNumber"] as? String ?? ""
		let isVerified: Bool = requestedData["isVerified"] as? Bool ?? false
		let isBanned: Bool = requestedData["isBanned"] as? Bool ?? false
		
		let storeImage: String = requestedData["storeImage"] as? String ?? ""
		
		let currentStoreUser = StoreInfo(storeId: storeId, storeName: storeName, storeEmail: storeEmail, storeLocation: storeLocation, registerDate: registerDate.formattedKoreanTime(), reportingCount: reportingCount, phoneNumber: phoneNumber, isVerified: isVerified, isBanned: isBanned)
		
		return currentStoreUser
	}
	
	// MARK: - Create
	/// Firestore의 DB에 스토어 유저가 자신의 Item을 생성합니다.
	/// 메소드의 아규먼트로 vm.currentStoreUserinfo.id를 전달합니다.
	public func createNewItem(with currentStoreUserUid: String?) async -> Void {
		 
	}
}

