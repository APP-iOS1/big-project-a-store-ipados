//
//  StoreNetworkManager.swift
//  BigProjectAStoreIpadOS
//
//  Created by 이승준 on 2022/12/28.
//

import SwiftUI
import FirebaseFirestore

// MARK: - StoreNetworkManager
/// Store의 데이터를 CRUD 할 수 있는 메소드를 포함하는 클래스 객체 입니다.
/// Publish가 필요한 뷰 데이터를 요청하면 따로 설정이 가능하니, 이승준을 호출해 주세요.
/// 메소드 이름은 Team A 코딩 컨벤션을 따릅니다.
/// - 구현 완료 : Read(StoreUser, StoreItem), Create(StoreItem), Delete(StoreItem)
/// - 구현 예정 :
final class StoreNetworkManager: ObservableObject {
	/// 앱이 실행되면서 사용될 "현재 로그인 중인 StoreUser"의 정보를 저장하는 publish 변수 입니다.
	@Published var currentStoreUserInfo: StoreInfo? = nil
	
	/// 현재 로그인 중인 StoreUser의 아이템 id를 보관하는 배열입니다.
	/// 보유 중인 Item을 그릴 때 ForEach로 전달하여 사용할 수 있습니다.
	@Published var currentStoreItemIdArray: [String] = []
	
	let path = Firestore.firestore().collection("\(appCategory.rawValue)")
	
	// MARK: - Methods
	// MARK: - Request
	/** 현재 접속 중인 사용자의 uid를 활용하여 뷰를 그릴 때 필요한 데이터를 가져오는 기반 코드 입니다.
	 - parameters with: Auth.auth().currentUser.uid
	 - returns: Void
	 */
	@MainActor
	public func requestStoreInfo(with currentStoreUserUid: String?) async -> Void {
		guard let currentStoreUserUid else { return }
		let storeUserPath = path.document("\(currentStoreUserUid)")
		
		do {
			let snapshot = try await storeUserPath.getDocument()
			if let requestedData = snapshot.data() {
				self.currentStoreUserInfo = makeCurrentStoreUser(with: requestedData)
			} else {
				dump("\(#function) - DEBUG: NO SNAPSHOT FOUND")
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
		let isSubmited: Bool = requestedData["isSubmited"] as? Bool ?? false
		let isBanned: Bool = requestedData["isBanned"] as? Bool ?? false
		
		let storeImage: String = requestedData["storeImage"] as? String ?? ""
		
		let currentStoreUser = StoreInfo(storeId: storeId, storeName: storeName, storeEmail: storeEmail, storeLocation: storeLocation, registerDate: registerDate.formattedKoreanTime(), reportingCount: reportingCount, phoneNumber: phoneNumber, isVerified: isVerified, isBanned: isBanned)
		
		return currentStoreUser
	}
	
	// MARK: - Read Item
	@MainActor
	public func requestItemList(with currentStoreUserUid: String?) async -> [String] {
		guard let currentStoreUserUid else { return [""] }
		let itemPath = path.document("\(currentStoreUserUid)")
			.collection("Item")
		
		var idArray: [String] = []
		do {
			let snapshot = try await itemPath.getDocuments()
			if snapshot.count != 0 {
				for document in snapshot.documents {
					let requestedData = document.data()
					let id = requestedData["id"] as? String ?? "NO ID?"
					idArray.append(id)
				}
			}
			self.currentStoreItemIdArray = idArray
			return currentStoreItemIdArray
		} catch {
			dump("\(error.localizedDescription)")
		}
		return self.currentStoreItemIdArray
	}
	
	// MARK: - Create Item
	/// Firestore의 DB에 스토어 유저가 자신의 Item을 생성합니다.
	/// - Parameter with: Auth.auth().currentUser.uid
	/// - Parameter item: 새로 생성될 ItemInfo 구조체를 생성 후 아규먼트 전달
	@MainActor
	public func createNewItem(with currentStoreUserUid: String?, item: ItemInfo) async -> Void {
		guard let currentStoreUserUid else { return }
		let storeItemPath = path.document("\(currentStoreUserUid)")
			.collection("Item")
			.document(item.itemUid)
		
		do {
			try await storeItemPath.setData([
				"id": item.itemUid,
				"storeId": item.storeId,
				"itemName": item.itemName,
				"itemCategory": item.itemCategory,
//				"itemAmount": item.itemAmount,
				"itemImage": item.itemImage,
				"price": item.price,
			], merge: true)
			
			await updateItemOption(with: item.itemAllOption, path: storeItemPath)
		} catch {
			dump("\(error.localizedDescription)")
		}
		
		self.currentStoreItemIdArray.append(item.itemUid)
	}
	
	// MARK: Update Item Option
	/// createNewItem(with:item:)의 호출 메소드입니다.
	private func updateItemOption(with itemOption: ItemOptions, path: DocumentReference) async -> Void {
		do {
			for (key, value) in itemOption.itemOptions {
				try await path.setData([
					"ItemAllOption": [
						key: value
					]
				], merge: true)
			}
		} catch {
			dump("\(error.localizedDescription)")
		}
		
	}
	
	// MARK: Remove Item
	/// db에 접근하여 Item을 삭제합니다.
	/// - Important: item을 삭제하면 그 내부의 리뷰와 정보도 함께 사라집니다.
	/// - Parameter from: Auth.auth().currentUser.uid
	/// - Parameter withItemUid: 삭제할 아이템의 uid를 전달
	public func removeItem(from currentStoreUserUid: String?, withItemUid item: String) async -> Void {
		guard let currentStoreUserUid else { return }
		do {
			try await path.document("\(currentStoreUserUid)")
				.collection("Item")
				.document(item)
				.delete()
		} catch {
			dump("\(#function) - DEBUG \(error.localizedDescription)")
		}
	}
}

