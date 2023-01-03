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
				
				await model.createStoreInfo(with: StoreInfo(storeId: "1234", storeEmail: "test@ma.com", registerDate: Date.getKoreanNowTimeString(), reportingCount: 0))
			}
    }
}

struct ModelTestView_Previews: PreviewProvider {
    static var previews: some View {
        ModelTestView()
    }
}
