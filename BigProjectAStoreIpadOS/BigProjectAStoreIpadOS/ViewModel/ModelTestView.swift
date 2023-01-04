////
////  ModelTestView.swift
////  BigProjectAStoreIpadOS
////
////  Created by 이승준 on 2023/01/02.
////

import SwiftUI
import FirebaseAuth

struct ModelTestView: View {
	@EnvironmentObject var model: StoreNetworkManager
	
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
			.task {
				
//				await model.createStoreInfo(with: StoreInfo(storeId: "1234", storeEmail: "test@ma.com", registerDate: Date.getKoreanNowTimeString(), reportingCount: 0))
				
//				await model.createNewItem(with: "1234", item: ItemInfo(itemUid: "1", storeId: "1234", itemName: "테스트", itemCategory: "모니터", itemAllOption: ItemOptions(itemOptions: [
//					"1" : ["테스트옵션"],
//					"2" : ["테스트옵션2"],
//					"3" : ["테스트옵션3"],
//				]), itemImage: ["이미지1"], price: 125_000))
				
				await model.createOrderedItemInfo(with: "ENXC8Fy13iM4A7b3eud1Mo33dzk1", in: "123", withItem: ItemInfo(itemUid: UUID().uuidString, storeId: "123", itemName: "Test", itemCategory: "모니터", itemAllOption: ItemOptions(itemOptions: [
					"색상":["빨강_1200"]
				]), itemImage: ["이미지1"], price: 125000))
			}
    }
}

struct ModelTestView_Previews: PreviewProvider {
    static var previews: some View {
        ModelTestView()
    }
}
