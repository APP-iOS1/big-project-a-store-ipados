//
//  DeliveryAllView.swift
//  BigProjectAStoreIpadOS
//
//  Created by 최한호 on 2022/12/28.
//

import SwiftUI

struct DeliveryAllView: View {
    
    @State private var deliveryHeader = [ "주문 상태", "주문 번호", "상품 번호", "상품 이름", "발송 날짜", "택배사", "송장번호"]
    
    @State private var sortOrder = [KeyPathComparator(\DeliveryModel.orderState)]
    
    
    //    @State private var sampleArr = sampleDeliveryData
    
    let columns = [
        GridItem(.flexible(),alignment: .leading),
        GridItem(.flexible(),alignment: .leading),
        GridItem(.flexible(),alignment: .leading),
        GridItem(.flexible(),alignment: .leading),
        GridItem(.flexible(),alignment: .leading),
        GridItem(.flexible(),alignment: .leading),
        GridItem(.flexible(),alignment: .leading)
    ]
    
    var body: some View {
        
        VStack(alignment: .leading) {
            
            Table(sampleDeliveryData, sortOrder: $sortOrder) {
                TableColumn("주문 상태", value: \.orderState) { delivery in
                    if delivery.orderState == "0" {
                        Text("배송 준비")
                    } else if delivery.orderState == "2" {
                        Text("배송 중")
                    } else {
                        Text("배송 완료")
                    }
                }
                TableColumn("발송 날짜", value: \.shippingDate)
                TableColumn("주문 번호", value: \.orderNumber)
                TableColumn("상품 번호", value: \.productNumber)
                TableColumn("상품 이름", value: \.productName)
                TableColumn("택배사", value: \.shipmentCompany)
                TableColumn("송장 번호", value: \.trackingNumber)
            }
            .onChange(of: sortOrder) {
                sampleDeliveryData.sort(using: $0)
            }
            
            //            LazyVGrid(columns: columns) {
            //
            //                ForEach(deliveryHeader, id: \.self) { headerItem in
            //                    Text("\(headerItem)")
            //                }
            //                .font(.headline)
            //                .padding(.bottom, 6)
            //
            //                ForEach(sampleArr.indices, id: \.self) { index in
            //                    Text("\(sampleArr[index].orderState)")
            //                    Text("\(sampleArr[index].orderNumber)")
            //                    Text("\(sampleArr[index].productNumber)")
            //                    Text("\(sampleArr[index].productName)")
            //                    Text("\(sampleArr[index].shippingDate)")
            //                    Text("\(sampleArr[index].shipmentCompany)")
            //                    Text("\(sampleArr[index].trackingNumber)")
            //                }
            //                .padding(.bottom, 3)
            //            }
            //            .padding()
        }
    }
}

struct DeliveryAllView_Previews: PreviewProvider {
    static var previews: some View {
        DeliveryAllView()
    }
}
