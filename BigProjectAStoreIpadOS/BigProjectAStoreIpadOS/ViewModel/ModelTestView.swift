//
//  ModelTestView.swift
//  BigProjectAStoreIpadOS
//
//  Created by 이승준 on 2023/01/02.
//

import SwiftUI
import FirebaseAuth

struct ModelTestView: View {
	@EnvironmentObject var model: StoreNetworkManager
	
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
			.task {
				let itemOption = ItemOptions(itemOptions: [
					"색상": ["빨강_4000", "파랑_6000"],
					"램추가": ["4gb_16000", "8gb_152000"]
				])
				
				await model.createNewItem(with: "Test",
                                          item: ItemInfo(
                                            itemUid: UUID().uuidString,
                                            storeId: Auth.auth().currentUser?.uid ?? "test",
                                            itemName: "뇌물",
                                            itemCategory: "키보드",
//                                            itemAmount: 5,
                                            itemAllOption: itemOption,
                                            itemImage: ["imagelink1", "imagelink2"],
                                            price: 2851000)
                )
				
				async let arr = model.requestItemList(with: "Test")
				await print(arr)
			}
    }
}

struct ModelTestView_Previews: PreviewProvider {
    static var previews: some View {
        ModelTestView()
    }
}
