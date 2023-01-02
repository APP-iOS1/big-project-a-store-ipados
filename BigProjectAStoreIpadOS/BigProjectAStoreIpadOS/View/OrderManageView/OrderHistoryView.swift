//
//  OrderHistory.swift
//  BigProjectAStoreIpadOS
//
//  Created by 추현호 on 2022/12/27.
//

import SwiftUI


struct OrderHistoryView: View {
    // 표에서 선택 지원
    @State private var selectedOrder = Set<CustomerOrder.ID>()
    
    @State private var customerOrders = [
        CustomerOrder(orderNumber: "1dfsf", orderTime: "2022-12-27 13:36", orderProduct: "맥북 프로", orderOption: "스페이스 그레이_0", orderQuantity: "2", purchaseConfirmation: "N"),
        CustomerOrder(orderNumber: "2sdef", orderTime: "2022-12-31 09:12", orderProduct: "아이패드", orderOption: "스페이스 그레이_0", orderQuantity: "3", purchaseConfirmation: "Y"),
        CustomerOrder(orderNumber: "3dfge", orderTime: "2023-01-03 12:00", orderProduct: "에어팟", orderOption: "흰색_0", orderQuantity: "1", purchaseConfirmation: "Y")
    ]
    
    // 정렬 지원 -
    @State private var sortOrder = [KeyPathComparator(\CustomerOrder.orderNumber)]
    
    var body: some View {
        VStack {
            Table (customerOrders, selection: $selectedOrder) {
                TableColumn("주문 번호", value: \.orderNumber)
                TableColumn("주문 시간", value: \.orderTime)
                TableColumn("주문 상품", value: \.orderProduct)
                TableColumn("주문 옵션", value: \.orderOption)
                TableColumn("주문 수량", value: \.orderQuantity)
                TableColumn("구매확인", value: \.purchaseConfirmation)
  
            }
            .onChange(of: sortOrder) {
                customerOrders.sort(using: $0)
            }
        }//.modifier(CloseUpDetailModifier())
    }//body
}



struct OrderHistory_Previews: PreviewProvider {
    static var previews: some View {
        OrderHistoryView()
            //.environmentObject(NavigationStateManager())
    }
}


/*
 NavigationStack {
     VStack {
         HStack {
             Text("목록 (총 2개)")
                 .font(.title2)
                 .padding(.leading, 20)
             Spacer()
         }
         Divider()
             .padding(.bottom, 10)
         LazyVGrid(columns: columns) {
             
             ForEach(Array(orderHistoryHeader.enumerated()), id: \.offset ) { idx, headerItem in
                 if idx == 5 {
                     Picker(selection: $orderConfirmSelection, label: Text("구매확인")) {
                         Text("구매확인 (전체)").tag(1)
                         Text("구매확인 Y").tag(2)
                         Text("구매확인 N").tag(3)
                     }
                 } else {
                     Text("\(headerItem)")
                 }
             }
             .font(.headline)
             .padding(.bottom, 6)
             
             if orderConfirmSelection == 1 {
                 ForEach(dummyDataTotal, id: \.self) { data in
                     Text("\(data)")
                 }
             } else if orderConfirmSelection == 2 {
                 ForEach(dummyDataYes, id: \.self) { data in
                     Text("\(data)")
                 }
             } else {
                 ForEach(dummyDataNo, id: \.self) { data in
                     Text("\(data)")
                 }
             }
             
         }
         Spacer()
         
     }//vstack
     .padding(.top, 20)
     .navigationTitle(Text("주문 내역"))
 }.modifier(CloseUpDetailModifier())

 */


