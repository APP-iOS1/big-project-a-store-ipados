//
//  DeliveryView.swift
//  BigProjectAStoreIpadOS
//
//  Created by 최한호 on 2022/12/27.
//

import SwiftUI

struct DeliveryView: View {
    
    @EnvironmentObject private var storeNetworkManager: StoreNetworkManager

    @State private var sortOrder = [KeyPathComparator(\DeliveryModel.shippingDate)]
    @State private var searchText = ""
    @State private var selected = Set<DeliveryModel.ID>()
    
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                DeliverySummaryView()
                
                Divider()
                
                Table(sampleDeliveryData, selection: $selected, sortOrder: $sortOrder) {
                    TableColumn("배송 상태", value: \.orderState) { delivery in
                        if delivery.orderState == "0" {
                            
                            Button {
                                //delivery.orderState = "2"
                            } label: {
                                HStack {
                                    Text("배송 준비")
                                        .foregroundColor(.black)
                                        .padding(5)
                                        .overlay(Rectangle()
                                            .stroke(Color.black, lineWidth:0.5))
                                    
                                    Spacer()
                                }
                            }
                            .frame(minWidth: 100)
                            
                        } else if delivery.orderState == "2" {
                            Button {
                                //delivery.orderState = "1"
                            } label: {
                                HStack {
                                    Text(" 배송 중 ")
                                        .foregroundColor(.black)
                                        .padding(5)
                                        .overlay(Rectangle()
                                            .stroke(Color.black, lineWidth:0.5))
                                    
                                    Spacer()
                                }
                            }
                            .frame(minWidth: 100)
                            
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
            }
            .searchable(text: $searchText, prompt: "검색")
            
            
        } // NavigationStack
    } // Body
}

struct DeliveryView_Previews: PreviewProvider {
    static var previews: some View {
        DeliveryView()
    }
}
