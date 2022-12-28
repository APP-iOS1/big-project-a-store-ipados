//
//  ChartDetailView.swift
//  BigProjectAStoreIpadOS
//
//  Created by kimminho on 2022/12/28.
//

import SwiftUI

struct ChartDetailView: View {
    //목록을 1부터 1000까지 만듬
    let data = Array(1...12).map { "목록 \($0)"}
    
    //화면을 그리드형식으로 꽉채워줌
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
            LazyVGrid(columns: columns,  spacing: 20) {
                ForEach(data, id: \.self) {i in
                 //VStack으로 도형추가
                   VStack {
                       ZStack {
                           Rectangle()
                               .fill(Color.yellow)
                               .frame(height: 200)
                           VStack(alignment: .leading) {
                               Text("sub Title")
                                   .font(.title3)
                               Text("Title")
                                   .font(.title)
                               Text("sub Title")
                                   .font(.title3)
                           }
                           .padding(EdgeInsets(top: 0, leading: 0, bottom: 100, trailing: 310))
                       }

                    }
                }
            }
            .padding(.horizontal)
    }
}

struct ChartDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ChartDetailView()
    }
}
