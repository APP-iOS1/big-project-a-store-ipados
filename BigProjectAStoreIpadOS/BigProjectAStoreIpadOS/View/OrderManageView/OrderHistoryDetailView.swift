//
//  OrderHistoryDetailView.swift
//  BigProjectAStoreIpadOS
//
//  Created by sehooon on 2023/01/04.
//

import SwiftUI

struct OrderHistoryDetailView: View {
    var orderInfo:OrderInfo

    var body: some View {
        Form{
            
            Section{
                Text("\(orderInfo.orderId)")
            } header: {
                Text("주문 번호")
                    .font(.largeTitle)
            }
            
            Section{
                Text("\(orderInfo.orderedUserInfo)")
            } header: {
                Text("주문 고객")
                    .font(.largeTitle)
            }
            
            Section{
                Text("\(orderInfo.orderTime)")
            } header: {
                Text("주문 시간")
                    .font(.largeTitle)
            }
            
            
            Section {
                VStack{
                ForEach(orderInfo.orderedItems) { item in
                        Text("\(item.itemName)")
                    }
                }
            } header: {
                HStack{
                    Text("주문 상품")
                        .font(.largeTitle)
                    
                }
                
            }
            
            Section {
                Text("\(orderInfo.orderAddress)")
            } header: {
                Text("배송지")
                    .font(.largeTitle)
            }
            
            
            Section {
                Text("\(orderInfo.payment)")
            } header: {
                Text("결제 방식")
                    .font(.largeTitle)
            }
            
            Section {
                Text("\(orderInfo.orderMessage ?? "해당 없음")")
            } header: {
                Text("주문 사항")
                    .font(.largeTitle)
            }
        }
        .onAppear{
            var t = orderInfo.orderedItems[0].option.itemOptions
            
            print(t)
        }
        
    }
}

//struct OrderHistoryDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        OrderHistoryDetailView()
//    }
//}
