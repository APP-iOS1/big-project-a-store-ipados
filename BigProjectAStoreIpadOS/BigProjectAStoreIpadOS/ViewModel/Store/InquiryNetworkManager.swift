//
//  InquiryNetworkManager.swift
//  BigProjectAStoreIpadOS
//
//  Created by 추현호 on 2023/01/04.
//

import SwiftUI
import Foundation
import Firebase
import FirebaseFirestore

final class InquiryNetworkManager : ObservableObject {
    @Published var customerService: [CustomerServiceInfo] = []
    let database = Firestore.firestore()

    // MARK: - Request CustomerService List (QnA)
        /// 사용자가 제품에 남긴 문의 사항과 그에 대한 판매자의 답변을 리스트로 요청합니다.
        /// - Parameter itemId: 선택된 아이템의 고유 id 값
        @MainActor
        func requestCustomerServiceList() async -> Void {
            do {
                let documents = try await database.collection(csCategory.rawValue)
                //                    .whereField("itemId", isEqualTo: itemId)
                    .getDocuments()
                self.customerService.removeAll()
                for document in documents.documents {
                    let id = document.documentID
                    let title = document["title"] as? String ?? ""
                    let description = document["description"] as? String ?? ""
                    let itemId = document["itemId"] as? String ?? ""
                    let itemName = document["itemName"] as? String ?? ""
                    let itemImage = document["itemImage"] as? Array<String> ?? []
                    let serviceDate = document["serviceDate"] as? Timestamp ?? Timestamp(date: Date.now)
                    let customerId = document["customerId"] as? String ?? ""
                    let orderId = document["orderId"] as? String ?? ""
                    let itemAllOption = document["itemAllOption"] as? ItemAllOption
                    let isAnswered = document["isAnswered"] as? Bool ?? false
                    self.customerService.append(CustomerServiceInfo(id: id, title: title, description: description, itemId: itemId, itemName: itemName, itemImage: itemImage, serviceDate: serviceDate, customerId: customerId, orderId: orderId, itemAllOption: itemAllOption, isAnswered: isAnswered))
                }
                print("\(customerService)")
            } catch {
                print(error.localizedDescription)
            }
        }

}
