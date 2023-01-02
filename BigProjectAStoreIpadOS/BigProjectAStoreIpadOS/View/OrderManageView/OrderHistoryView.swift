//
//  OrderHistory.swift
//  BigProjectAStoreIpadOS
//
//  Created by 추현호 on 2022/12/27.
//

import SwiftUI


struct OrderHistoryView: View {
    
    @State private var customerOrders = [
        CustomerOrder(orderNumber: "1dfsf", orderTime: "2022-12-27 13:36", orderProduct: "맥북 프로", orderOption: "스페이스 그레이_0", orderQuantity: 2, purchaseConfirmation: false),
        CustomerOrder(orderNumber: "2sdef", orderTime: "2022-2-1 09:12", orderProduct: "아이패드", orderOption: "스페이스 그레이_0", orderQuantity: 3, purchaseConfirmation: true),
        CustomerOrder(orderNumber: "3dfge", orderTime: "2023-01-03 12:00", orderProduct: "에어팟", orderOption: "흰색_0", orderQuantity: 1, purchaseConfirmation: false),
        CustomerOrder(orderNumber: "4ddge", orderTime: "2020-01-01 22:00", orderProduct: "에어팟", orderOption: "흰색_0", orderQuantity: 6, purchaseConfirmation: true)
    ]
    
    // 표에서 선택 지원
    @State private var selectedOrder = Set<CustomerOrder.ID>()
    
    // 정렬 지원 - 일단은 주문 시간 순서대로 정렬
    @State private var sortOrder = [KeyPathComparator(\CustomerOrder.orderTime)]
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                Table (customerOrders, selection: $selectedOrder, sortOrder: $sortOrder) {
                    TableColumn("주문 번호", value: \.orderNumber)
                    TableColumn("주문 시간", value: \.orderTime)
                    TableColumn("주문 상품", value: \.orderProduct)
                    TableColumn("주문 옵션") { order in
                        Text("\(order.orderOption)")
                    }
                    TableColumn("주문 수량") { order in
                        Text("\(order.orderQuantity)")
                        
                    }
                    TableColumn("구매확인", value: \.purchaseConfirmationInt) { order in
                        Text(order.purchaseConfirmation ? "Y": "N")
                    }
                }
                .padding(.vertical, 20)
                .onChange(of: sortOrder) {
                    customerOrders.sort(using: $0)
                }
            }//v
            .navigationTitle("주문 내역")
        }//navigationstack
        //.modifier(CloseUpDetailModifier())
        
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


