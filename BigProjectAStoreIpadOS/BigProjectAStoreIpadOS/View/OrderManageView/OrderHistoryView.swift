//
//  OrderHistory.swift
//  BigProjectAStoreIpadOS
//
//  Created by 추현호 on 2022/12/27.
//

import SwiftUI

struct OrderHistoryView: View {
    // 나중에 customerOrderVM 필요할 것 같아서 일단 만들어보고 있었음
    @StateObject private var customerOrderVM: CustomerOrderViewModel = CustomerOrderViewModel()
    @State private var orderConfirmSelection: Int = 1
    
    // 그리드 6개씩 보여주기 위해
    var columns: [GridItem] = Array(repeating: .init(.flexible()), count: 6)
    
    
    // 주문 내역 부분
    let orderHistoryHeader: [String] = ["주문 번호", "주문 시간", "주문 상품", "주문 옵션", "수량", "구매확정 여부"]
    
    // 임의 주문 데이터
    let dummyDataTotal: [String] = ["1dfsf", "2022-12-27 13:36",  "맥북 프로", "스페이스 그레이", "2", "N", "2adsfg", "2022-12-28 19:36",  "아이패드", "- ", "1", "Y" ]
    let dummyDataYes: [String] = ["2adsfg", "2022-12-28 19:36",  "아이패드", "- ", "1", "Y"]
    let dummyDataNo: [String] = ["1dfsf", "2022-12-27 13:36",  "맥북 프로", "스페이스 그레이", "2", "N"]
    @State var showData: [String] = []
    
    var body: some View {
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
    }//body
}



struct OrderHistory_Previews: PreviewProvider {
    static var previews: some View {
        OrderHistoryView()
            .environmentObject(NavigationStateManager())
    }
}
