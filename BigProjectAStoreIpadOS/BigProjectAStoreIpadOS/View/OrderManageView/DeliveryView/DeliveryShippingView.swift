//
//  DeliveryShippingView.swift
//  BigProjectAStoreIpadOS
//
//  Created by 최한호 on 2022/12/28.
//

import SwiftUI

struct DeliveryShippingView: View {
    
    @State private var deliveryHeader = [ "주문 상태", "주문 번호", "상품 번호", "상품 이름", "발송 날짜", "택배사", "송장번호"]
    
    @State private var sampleArr = sampleDeliveryData

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
            
            LazyVGrid(columns: columns) {
                
                ForEach(deliveryHeader, id: \.self) { headerItem in
                    Text("\(headerItem)")
                }
                .font(.headline)
                .padding(.bottom, 6)
                
                ForEach(sampleArr.indices, id: \.self) { index in
                    if sampleArr[index].orderState == "배송중" {
                        Text("\(sampleArr[index].orderState)")
                        Text("\(sampleArr[index].orderNumber)")
                        Text("\(sampleArr[index].productNumber)")
                        Text("\(sampleArr[index].productName)")
                        Text("\(sampleArr[index].shippingDate)")
                        Text("\(sampleArr[index].shipmentCompany)")
                        Text("\(sampleArr[index].trackingNumber)")
                    }
                }
                .padding(.bottom, 3)
            }
            .padding()
        }
    }
}

struct DeliveryShippingView_Previews: PreviewProvider {
    static var previews: some View {
        DeliveryShippingView()
    }
}
