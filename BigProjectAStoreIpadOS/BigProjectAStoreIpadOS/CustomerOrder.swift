//
//  CustomerOrder.swift
//  BigProjectAStoreIpadOS
//
//  Created by Sue on 2022/12/27.
//

import SwiftUI

struct CustomerOrder: Identifiable {
    let id = UUID()
    var orderNumber: String
    var orderTime: String
    var orderProduct: String
    var orderOption: String
    var orderQuantity: String
    var purchaseConfirmation: String
    
}



//struct CustomerOrder: Identifiable, Hashable{
//    var id = UUID()
//    var orderNumber: String
//    var orderProduct: [String]
//    var orderTime: String //TimeStamp?
//    var orderOption: String
//    var orderQuantity: Int
//    var purchaseConfirmation: Bool
//
//
//    var orderProductTotalString: String {
//        var total: String = ""
//        for product in orderProduct {
//            total += "\(product)\n"
//        }
//        return total
//    }
//
//    // 구매 확정 여부 - Y / N
//    var purchaseConfirmationString: String {
//        if purchaseConfirmation {
//            return "Y"
//        } else {
//            return "N"
//        }
//    }
//
//
//}
//
//class CustomerOrderViewModel: ObservableObject {
//    @Published var orderLists:  [CustomerOrder]
//
//    init() {
//        orderLists = [
//            CustomerOrder(orderNumber: "1", orderProduct: ["맥북", "아이패드"], orderTime: "2022-12-27 13:18", orderOption: "스페이스 그레이_0", orderQuantity: 2, purchaseConfirmation: false),
//            CustomerOrder(orderNumber: "2", orderProduct: ["키보드"], orderTime: "2022-12-28 14:00", orderOption: "흰색_1000", orderQuantity: 2, purchaseConfirmation: true)
//        ]
//    }
//}
