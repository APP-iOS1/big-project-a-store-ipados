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
/// - 구현 완료 : Read(StoreUserInfo, StoreItem, StoreItemId, StoreReview), Create(StoreItem), Delete(StoreItem)
/// - 구현 예정 : Delete(Store Review), Create(Order info), Update(StoreInfo)
final class StoreNetworkManager: ObservableObject {
	/// 앱이 실행되면서 사용될 "현재 로그인 중인 StoreUser"의 정보를 저장하는 publish 변수 입니다.
	@Published var currentStoreUserInfo: StoreInfo? = nil
	
	/// 현재 로그인 중인 StoreUser의 아이템 id를 보관하는 배열입니다.
	/// 보유 중인 Item을 그릴 때 ForEach로 전달하여 사용할 수 있습니다.
	@Published var currentStoreItemIdArray: [String] = []
	
	/// 하나의 아이템에 대한 리뷰 정보 구조체를 원소로 갖는 배열 입니다.
	@Published var eachItemReviews: [ReviewInfo] = []
	
	/// 스토어가 관리하는 모든 아이템을 보관하는 배열입니다.
	@Published var currentStoreItemArray: [ItemInfo] = []
	
	/// 스토어가 관리하는 모든 주문정보 배열입니다.
	@Published var currentStoreOrderInfoArray: [OrderInfo] = []
	
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
				guard let currentStoreUserInfo else { return }
				setStoreApproveStatement(with: currentStoreUserInfo)
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
		let isSubmitted: Bool = requestedData["isSubmitted"] as? Bool ?? false
		let isBanned: Bool = requestedData["isBanned"] as? Bool ?? false
		
		let storeImage: String = requestedData["storeImage"] as? String ?? ""
		
        let currentStoreUser = StoreInfo(storeId: storeId, storeEmail: storeEmail, registerDate: registerDate.formattedKoreanTime(), reportingCount: reportingCount,   phoneNumber: phoneNumber, storeLocation: storeLocation, storeName: storeName, isVerified: isVerified, isSubmitted: isSubmitted, isBanned: isBanned)
		
		return currentStoreUser
	}
	
	// MARK: - Set Store Approvement State
	/// 스토어 유저의 인증 상태에 따라 열거형 인스턴스 값을 변경합니다.
	private func setStoreApproveStatement(with userInfo: StoreInfo) {
		if userInfo.isSubmitted {
			storeApproveState = .submitted
		} else if userInfo.isVerified {
			storeApproveState = .approved
		} else if userInfo.isBanned {
			storeApproveState = .banned
		} else if userInfo.isSubmitted == false {
			storeApproveState = .needSubmit
		}
	}
	
	// MARK: - Update Store Info
	/// 스토어 유저의 정보를 업데이트 합니다.
	/// - Parameter with: Auth.auth().currentUser?.uid
	/// - Parameter by: 어떤 데이터를 업데이트할지 열거형으로 정의되어 있는 value에 전달합니다.
	public func updateStoreInfo(with currentStoreUserUid: String?,
								by storeInfo: StoreInfoUpdateType...) async -> Void {
		guard let currentStoreUserUid else { return }
		print(#function)
		let storePath = path.document(currentStoreUserUid)
		do {
			for updateInfo in storeInfo {
				switch updateInfo {
				case .storeId(let key, let value),
						.storeName(let key, let value),
						.storeEmail(let key, let value),
						.storeLocation(let key, let value),
						.phoneNumber(let key, let value):
					try await storePath.updateData([
						key: value
					])
				case .registerDate(let key, let value):
					try await storePath.updateData([
						key: value
					])
				case .reportingCount(let key, let value):
					try await storePath.updateData([
						key: value
					])
				case .storeImage(let key, let value):
					try await storePath.updateData([
						key: value
					])
				case .isVerified(let key, let value),
						.isSubmitted(let key, let value),
						.isBanned(let key, let value):
					try await storePath.updateData([
						key: value
					])
				}
			}
		} catch {
			dump("\(#function) - DEBUG \(error.localizedDescription)")
		}
	}
	
	// MARK: - Create Store Info
	/// - Important: DEPRECATED
	public func createStoreInfo(with storeUser: StoreInfo) async -> Void {
		do {
			try await path.document(storeUser.storeId).setData([
				"storeId": storeUser.storeId,
				"storeEmail": storeUser.storeEmail,
				"registerDate": storeUser.registerDate,
				"reportingCount": storeUser.reportingCount,
				"isVerified": storeUser.isVerified,
				"isSubmitted": storeUser.isSubmitted,
				"isBanned": storeUser.isBanned
//				"storeImage": storeUser.storeImage,
//				"phoneNumber": storeUser.phoneNumber,
//				"storeLocation": storeUser.storeLocation,
//				"storeName": storeUser.storeName
			], merge: true)
			
			try await path.document(storeUser.storeId).collection("Notification").document("알람").setData([
				"init":""
			], merge: true)
			
			try await
			path.document(storeUser.storeId).collection("Sales").document("init")
				.setData([
					"init":""
				], merge: true)
			
			try await path.document(storeUser.storeId).collection("Items").document("init").collection("Reviews").document("리뷰").setData([
				"init":""
			], merge: true)
			
			try await
			path.document(storeUser.storeId).collection("Items").document("init").collection("OrderedInfo").document("주문정보").setData([
				"init":""
			], merge: true)
			
		} catch {
			dump("\(#function) - DEBUG \(error.localizedDescription)")
		}
		
	}
	
	// MARK: - Read Item Id
	@MainActor @discardableResult
	public func requestItemIdList(with currentStoreUserUid: String?) async -> [String] {
		guard let currentStoreUserUid else { return [""] }
		let itemPath = path
			.document("\(currentStoreUserUid)")
			.collection("Items")
		
		var idArray: [String] = []
		do {
			let snapshot = try await itemPath.getDocuments()
			if snapshot.count != 0 {
				for document in snapshot.documents {
					let requestedData = document.data()
					let id = requestedData["itemUid"] as? String ?? "NO ID?"
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
	
	// MARK: Read all Item Info
	@MainActor
	public func requestItemInfo(with currentStoreUserUid: String?) async -> Void {
		await requestItemIdList(with: currentStoreUserUid)
		guard let currentStoreUserUid else { return }
		let path = self.path
			.document(currentStoreUserUid)
			.collection("Items")

		do {
            self.currentStoreItemArray.removeAll()
			for id in currentStoreItemIdArray {
				let requestedItemData = try await path.document(id).getDocument().data()
				guard let requestedItemData else { continue }
				
				let itemUid: String = requestedItemData["itemUid"] as? String ?? ""
				let storeId: String = requestedItemData["storeId"] as? String ?? ""
				let itemName: String = requestedItemData["itemName"] as? String ?? ""
				let itemCategory: String = requestedItemData["itemCategory"] as? String ?? ""

				let itemImage: [String] = requestedItemData["itemImage"] as? [String] ?? [""]
				let price: Double = requestedItemData["price"] as? Double ?? 0.0
				
				let itemAllOption = requestedItemData["ItemAllOption"] as? [String: Any] ?? [:]
				var itemAllOptions = ItemOptions(itemOptions: [:])
				
				for (key, value) in itemAllOption {
					let options = value as? [String]
					guard let options else { continue }
					itemAllOptions.itemOptions.updateValue(options, forKey: key)
				}
				

				let requestedItem = ItemInfo(itemUid: itemUid, storeId: storeId, itemName: itemName, itemCategory: itemCategory,  itemAllOption: itemAllOptions, itemImage: itemImage, price: price)

				
				self.currentStoreItemArray.append(requestedItem)
			}
		} catch {
			dump("\(#function) - DEBUG \(error.localizedDescription)")
		}
		
	}
	
	// MARK: - Create Item
	/// Firestore의 DB에 스토어 유저가 자신의 Item을 생성합니다.
	/// - Parameter with: Auth.auth().currentUser.uid
	/// - Parameter item: 새로 생성될 ItemInfo 구조체를 생성 후 아규먼트 전달
	@MainActor
	public func createNewItem(with currentStoreUserUid: String?, item: ItemInfo) async -> Void {
		guard let currentStoreUserUid else { return }
		let storeItemPath = path.document("\(currentStoreUserUid)")
			.collection("Items")
			.document(item.itemUid)
		
		do {
			try await storeItemPath.setData([
				"itemUid": item.itemUid,
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
					"itemAllOption": [
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
				.collection("Items")
				.document(item)
				.delete()
		} catch {
			dump("\(#function) - DEBUG \(error.localizedDescription)")
		}
	}
	
	// MARK: - Read All Reviews in Item
	/// db에 저장된 아이템에 대한 모든 리뷰를 읽어옵니다.
	/// - Parameter with: Auth.auth().currentUser?.uid
	/// - Parameter fromItemId: 조회 중인 아이템의 "id"
	/// - Returns: Void
	@MainActor
	public func requestItemReviews(with currentStoreUserUid: String?,
								   fromItemId itemUid: String) async -> Void {
		guard let currentStoreUserUid else { return }
		let reviewPath = path.document("\(currentStoreUserUid)")
			.collection("Items")
			.document(itemUid)
			.collection("Reviews")
		
		do {
			let snapshot = try await reviewPath.getDocuments()
			for document in snapshot.documents {
				let requestedData = document.data()
				
				let reviewPostId = requestedData["reviewPostId"] as? String ?? ""
				let itemId = requestedData["itemId"] as? String ?? ""
				let storeId = requestedData["storeId"] as? String ?? ""
				let reviewerId = requestedData["userId"] as? String ?? ""
				let reviewPostDescription = requestedData["reviewPostDescription"] as? String ?? ""
				let postDate = requestedData["postDate"] as? Timestamp ?? Timestamp(date: Date.now)
				let rate = requestedData["rate"] as? Int ?? 0
				
				let orderedItems = requestedData["orderedItems"] as? [String: Any] ?? [:]
				let orderedItem = await getOrderedItemData(with: orderedItems)
				
				let review = ReviewInfo(reviewPostId: reviewPostId, itemId: itemId, storeId: storeId, reviewerId: reviewerId, postDescription: reviewPostDescription, postDate: postDate.formattedKoreanTime(), rate: rate, orderedItem: [orderedItem])
				
				eachItemReviews.append(review)
			}
		} catch {
			dump("\(#function) - DEBUG \(error.localizedDescription)")
		}
	}
	
	// MARK: - 주문한 아이템의 데이터 생성 메소드
	/// 가져온 리뷰 데이터에서 주문한 아이템의 옵션을 가져오는 내부 메소드 입니다.
	private func getOrderedItemData(with orderedItems: [String: Any]) async -> OrderedItemInfo {
		let itemUid = orderedItems["itemUid"] as? String ?? ""
		let price = orderedItems["price"] as? Double ?? 0.0
		let deliveryStatus = orderedItems["deliveryStatus"] as? String ?? ""
		var itemName: String = ""
		var itemImage: [String] = [""]
		
		do {
			if let snapshot = try await path.document(currentStoreUserInfo!.storeId).collection("Items").document(itemUid).getDocument().data() {
				itemName = snapshot["itemName"] as? String ?? ""
				itemImage = snapshot["itemImage"] as? [String] ?? [""]
			}
		} catch {
			dump("\(#function) - DEBUG \(error.localizedDescription)")
		}
		
		// Item Option
		let selectedOption = orderedItems["selectedOption"] as? [String: Any] ?? [:]
		var itemOptionDict = ItemOptions(itemOptions: [:])
		for (key, value) in selectedOption {
			let myOption = value as? [String]
			guard let myOption else { continue }
			itemOptionDict.itemOptions.updateValue(myOption, forKey: key)
		}
		
		return OrderedItemInfo(itemUid: itemUid, itemName: itemName, itemImage: itemImage, price: price, option: itemOptionDict, deliveryStatus: deliveryStatus)
	}
	
	// MARK: - 스토어의 모든 아이템에 대한 주문 정보 불러오기
	public func requestOrderedItemInfo(with currentUserUid: String?) async -> Void {
		guard let currentUserUid else { return }
		let orderedInfoPath = path.document(currentUserUid)
			.collection("Items")
			
		var requestedOrderInfo: [OrderInfo] = []
		
		do {
			if self.currentStoreItemArray.isEmpty { // id 어레이가 비어있으면 id 를 채웁니다.
				await requestItemIdList(with: currentUserUid)
			}
            else {
                currentStoreItemArray.removeAll()
            }
			for itemId in self.currentStoreItemIdArray {
				let requestedSnapshot = try await orderedInfoPath.document(itemId).collection("OrderedInfo").getDocuments()
				
				for docs in requestedSnapshot.documents {
					let requestedData = docs.data()
					
					/// orderinfos
					let orderId: String = requestedData["orderId"] as? String ?? ""
					let orderedUserInfo: String = requestedData["orderedUserInfo"] as? String ?? ""
					let orderTime: String = requestedData["orderTime"] as? String ?? ""
					let orderAddress: String = requestedData["orderAddress"] as? String ?? ""
					let orderMessage: String? = requestedData["orderMessage"] as? String ?? ""
					let payment: String = requestedData["payment"] as? String ?? ""
					
					let orderedItems = requestedData["orderedItems"] as? [String: Any] ?? [:]
					
					/// orderediteminfo
					let itemUid: String = orderedItems["itemUid"] as? String ?? ""
					let itemName: String = orderedItems["itemName"] as? String ?? ""
					let itemImage: [String] = orderedItems["itemImage"] as? [String] ?? [""]
					let price: Double = orderedItems["price"] as? Double ?? 0.0
					let deliveryStatus: String = orderedItems["deliveryStatus"] as? String ?? ""
					
					
					/// itemOptions
					let orderedOptions = orderedItems["option"] as? [String: Any] ?? [:]
					var itemOptions = ItemOptions(itemOptions: [:])
					
					for (key, value) in orderedOptions {
						itemOptions.itemOptions.updateValue(value as! [String], forKey: key)
					}
					
					let orderedItemInfo = OrderedItemInfo(itemUid: itemUid, itemName: itemName, itemImage: itemImage, price: price, option: itemOptions, deliveryStatus: deliveryStatus)
					
					let orderInfo = OrderInfo(orderId: orderId, orderedUserInfo: orderedUserInfo, orderTime: orderTime, orderedItems: [orderedItemInfo], orderAddress: orderAddress, orderMessage: orderMessage ?? "", payment: payment)
					
					requestedOrderInfo.append(orderInfo)
					self.currentStoreOrderInfoArray = requestedOrderInfo
				}
			}
		} catch {
			dump("\(#function) - DEBUG \(error.localizedDescription)")
		}
	}
	
	// MARK: - 주문된 아이템의 정보 생성 메소드
	/// 구매한 유저의 id를 참조 경로로 삼고 가서 그 유저의 서브 콜렉션에도 저장해야 함
	/// 스토어의 모든 아이템 id를 가져온 다음,
	/// 주문 건은 하나고, 그 안에 여러 아이템의 id를 다 갖고 있어야 함.
	public func createOrderedItemInfo(with currentUserUid: String?,
									  in currentStoreUserUid: String?,
									  withItem item: ItemInfo...) async -> Void {
		guard let currentStoreUserUid, let currentUserUid else { return }

		// 주문한 아이템의 정보를 담는 배열
		var orderedItemsArray: [OrderedItemInfo] = []
		
		for orderedItem in item {
			let orderedItemsInfo = OrderedItemInfo(itemUid: orderedItem.itemUid, itemName: orderedItem.itemName, itemImage: orderedItem.itemImage, price: orderedItem.price, option: orderedItem.itemAllOption, deliveryStatus: "배송준비중")
			orderedItemsArray.append(orderedItemsInfo)
		}
		
		// 주문 정보 생성
		let newOrderInfo = OrderInfo(orderId: UUID().uuidString, orderedUserInfo: currentUserUid, orderTime: Date.getKoreanNowTimeString(), orderedItems: orderedItemsArray, orderAddress: "배송주소", payment: "무통장입금")
		
		do {
			for orderdItemInfo in orderedItemsArray {
				let path = path.document(currentStoreUserUid)
					.collection("Items").document(orderdItemInfo.itemUid) // 서로 다른 아이템 id에 하나의 주문 건 아이디만 넣어주기
					.collection("OrderedInfo").document(newOrderInfo.orderId) // 주문 건 아이디는 유지
				
				// 안에다가 주문정보 채우기
				try await path.setData([
					:
				])
			}
		} catch {
			dump("\(#function) - DEBUG \(error.localizedDescription)")
		}
		
	}
}
