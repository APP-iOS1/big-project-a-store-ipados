//
//  ProductInventoryView.swift
//  BigProjectAStoreIpadOS
//
//  Created by sehooon on 2022/12/27.
//

import SwiftUI

struct ProductInventoryView: View {
    
    
    let data = (1...100).map { "Item \($0)" }
    let columns = [ GridItem(.adaptive(minimum: 80)) ]
    @State private var productCategories = [
        "상품명",
        "상품코드",
        "옵션",
        "재고",
        "조정사유"
    ]

    
    var body: some View {
        
     
        
        
        VStack(){

            Text("상품 조회/수정")
                .font(.largeTitle)
            
            Divider()
            productStatusBar
            
            Divider()
            
            // MARK: - 상품 조회 기능
            VStack(alignment: .leading){
                HStack{
                    Text("카테고리")
                        .font(.title3)
                }
                Divider()

                HStack{
                    Text("상품등록일")
                        .font(.title3)
                    Spacer()
                }
                Divider()
                HStack{
                    Text("부족재고")
                        .font(.title3)
                    Spacer()
                }
                Divider()

            }
            .padding()
            
            
            // MARK: - 상품목록 View
            VStack(alignment: .leading){
                Text("상품 목록 (총 0개)")
                    .font(.title2)
                    .padding()
                Divider()
                VStack{
                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 20) {
                          
                            ForEach(data, id: \.self) { item in
                                Text(item)
                            }
                        }
                        .padding(.horizontal)
                    }
                    .frame(maxHeight: 300)
                    .padding()
                }
            }
            
            Spacer()
        }
        
    }
}
extension ProductInventoryView{
    
    var productStatusBar: some View{
        VStack{
            HStack(alignment: .center ,spacing: 50){
                HStack{
                    Image(systemName: "shippingbox.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50,height: 50)
                    VStack(alignment: .leading){
                        Text("전체")
                        Text("0 ")                            .font(.title2) + Text("건")
                    }
                    .padding()
                }
                
                HStack{
                    Image(systemName: "cart.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50,height: 50)
                    VStack(alignment: .leading){
                        Text("품절")
                        Text("0 ")                            .font(.title2) + Text("건")
                    }
                    .padding()
                }
                
                HStack{
                    Image(systemName: "cart.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50,height: 50)
                    VStack(alignment: .leading){
                        Text("판매중")
                        Text("0 ")
                            .font(.title2) + Text("건")
                    }
                    .padding()
                }
                
            }
            
        }
    }
}

struct ProductInventoryView_Previews: PreviewProvider {
    static var previews: some View {
        ProductInventoryView()
    }
}
