//
//  ProductModifyView.swift
//  BigProjectAStoreIpadOS
//
//  Created by sehooon on 2022/12/27.
//

import SwiftUI

struct ProductModifyView: View {
    
    @Binding var index: Int
    @State var productCount = ""
    
    var body: some View {
        VStack(alignment: .leading){
            HStack{
                Image(systemName: "keyboard")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150)
                VStack(alignment: .leading,spacing: 10){
                    Text("상품명: \(sampleData[index].productName)")
                        .font(.title)
                    Text("상품 코드: \(sampleData[index].productId)")
                }
                .padding()
            }

            
            
            // 날짜
            HStack{
                Text("등록 날짜: 2022-12-27")
                    .font(.title)
            }
            .padding()
    
            
            HStack{
                Text("상품 옵션: \(sampleData[index].productPrice)")
                    .font(.title)
            }
            .padding()
            
            
            // 재고 수량
            HStack(spacing: 40){
                Text("현재 재고 수량: \(sampleData[index].productCount)")
                    .font(.title)
                TextField("재고 수량", text: $productCount)
                    .frame(width:200)
                Button {
                    if let number =  Int(productCount){
                        sampleData[index].productCount = number
                    }
                    productCount = ""
                } label: {
                    Text("저장")
                }
            }
            .padding()
            
            
        }
        
        
            
    }
}

struct ProductModifyView_Previews: PreviewProvider {
    static var previews: some View {
        ProductModifyView(index: .constant(0))
    }
}
