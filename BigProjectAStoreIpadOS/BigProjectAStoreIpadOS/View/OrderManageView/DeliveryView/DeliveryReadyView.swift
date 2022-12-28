//
//  DeliveryReadyView.swift
//  BigProjectAStoreIpadOS
//
//  Created by 최한호 on 2022/12/28.
//

import SwiftUI

struct DeliveryReadyView: View {
    
    
    
    @State private var deliveryCategories = [ "주문 상태", "주문 번호", "상품 번호", "상품 이름", "발송 날짜", "택배사", "송장번호"]
    
    @State private var sampleArr = sampleDeliveryData
    
    let columns = [
        GridItem(.flexible(),alignment: .center),
        GridItem(.flexible(),alignment: .center),
        GridItem(.flexible(),alignment: .center),
        GridItem(.flexible(),alignment: .center),
        GridItem(.flexible(),alignment: .center),
        GridItem(.flexible(),alignment: .center),
        GridItem(.flexible(),alignment: .center)
    ]
    
    
    var body: some View {
        // 목록 Table
        ScrollView() {
            
            HStack {
                Text("주문 상태")
                    .padding(10)
                Text("주문 번호")
                    .padding(10)
                Text("상품 번호")
                    .padding(10)
                Text("상품 이름")
                    .padding(10)
                Text("발송 날짜")
                    .padding(10)
                Text("택배사")
                    .padding(10)
                Text("송장 번호")
                    .padding(10)
                
            }
            .bold()
            .font(.title2)
                
                //                LazyVGrid(columns: columns) {
                //                    Group{
                //                        ForEach(deliveryCategories, id: \.self ) { category in
                //                            Text("\(category)")
                //                        }
                //                    }
                //                    .font(.headline)
                //                    ForEach(sampleArr.indices, id: \.self) { index in
                //                        Text(sampleArr[index].orderState)
                //                        Text(sampleArr[index].orderNumber)
                //                        Text(sampleArr[index].productNumber)
                //                        Text(sampleArr[index].productName)
                //                        Text(sampleArr[index].shippingDate)
                //                        Text(sampleArr[index].shipmentCompany)
                //                        Text(sampleArr[index].trackingNumber)
                //
                //                    }
                //                    .padding()
                
            
        }
    }
}

struct DeliveryReadyView_Previews: PreviewProvider {
    static var previews: some View {
        DeliveryReadyView()
    }
}
