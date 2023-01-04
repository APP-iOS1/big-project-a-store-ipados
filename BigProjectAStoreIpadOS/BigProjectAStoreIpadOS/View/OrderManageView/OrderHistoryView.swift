//
//  OrderHistory.swift
//  BigProjectAStoreIpadOS
//
//  Created by 추현호 on 2022/12/27.
//

import FirebaseAuth
import SwiftUI


struct OrderHistoryView: View {
    
    @EnvironmentObject private var storeNetworkManager: StoreNetworkManager
    @State private var searchText: String = ""
    
    // 표에서 선택 지원
    @State private var selectedOrder = Set<OrderInfo.ID>()
    
    // 정렬 지원 - 일단은 주문 시간 순서대로 정렬
    @State private var sortOrder = [KeyPathComparator(\OrderInfo.orderTime)]
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                Table (storeNetworkManager.currentStoreOrderInfoArray, selection: $selectedOrder, sortOrder: $sortOrder) {
                    TableColumn("주문 번호", value: \.orderId)
                    TableColumn("주문 시간", value: \.orderTime)
                    TableColumn("주문 고객", value:\.orderedUserInfo)
                    TableColumn("주문 상품"){ product in
                        if !product.orderedItems.isEmpty{
                            Text("\(product.orderedItems.first!.itemName) 외 \(product.orderedItems.count - 1)개")
                        }else{
                            Text("")
                        }
                    }
                    TableColumn("상세 보기"){ product in
                        NavigationLink {
                            OrderHistoryDetailView(orderInfo: product)
                        } label: {
                            Text("상세 보기")
                                .foregroundColor(.black)
                                .padding(5)
                                .overlay(Rectangle().stroke(Color.black, lineWidth: 0.5))
                        }

                        
                    }

                }
                .refreshable{
                    await storeNetworkManager.requestOrderedItemInfo(with:Auth.auth().currentUser?.uid)
                }
                .padding(.vertical, 20)
                .onChange(of: sortOrder) {
                    storeNetworkManager.currentStoreOrderInfoArray.sort(using: $0)
                }
            }//v
//            .searchable(text: $searchText, prompt: "주문 번호 입력")
            .onAppear{
                Task{
                  await storeNetworkManager.requestOrderedItemInfo(with:Auth.auth().currentUser?.uid)
                }
                
            }
            .navigationTitle("주문 내역")
            
        }//navigationstack
        //.modifier(CloseUpDetailModifier())
        
    }//body
}



struct OrderHistory_Previews: PreviewProvider {
    static var previews: some View {
        OrderHistoryView()
            .environmentObject(StoreNetworkManager())
    }
}

