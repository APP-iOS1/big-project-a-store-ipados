//
//  OrderHistory.swift
//  BigProjectAStoreIpadOS
//
//  Created by 추현호 on 2022/12/27.
//

import SwiftUI

struct OrderHistory: View {
    var columns: [GridItem] = Array(repeating: .init(.flexible()), count: 6)
    let header: [String] = ["주문 번호", "주문 시간", "주문 상품", "주문 옵션", "수량", "구매확정 여부"]
    let dummyData: [String] = ["1dfsf", "2022-12-27 13:36",  "맥북 프로", "매직키보드", "2", "N", "2adsfg", "2022-12-28 19:36",  "아이패드", "- ", "1", "N" ]
    
    var body: some View {
        ScrollView {
            VStack {
                Text("주문내역")
                    .font(.title)
                    .bold()
                    
                
                LazyVGrid(columns: columns) {
                    
                    ForEach(header, id: \.self ) { headerItem in
                        Text("\(headerItem)")
                    }
                    

                    
                    ForEach(dummyData, id: \.self) { data in
                        Text("\(data)")
                    }
                    
                }
                Spacer()
                
            }//vstack
        }
    }//body
}



struct OrderHistory_Previews: PreviewProvider {
    static var previews: some View {
        OrderHistory()
    }
}
