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
				
				await model.updateStoreInfo(with: "UaKxPUQgK7bqmJb9fRbN95BZ21M2",
											by: .storeName(value: "이름바꿀거임"), .isSubmitted(value: true), .registerDate(value: Date.now))
			}
    }
}

struct ModelTestView_Previews: PreviewProvider {
    static var previews: some View {
        ModelTestView()
    }
}
