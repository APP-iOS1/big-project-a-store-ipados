//
//  ProductInventoryView.swift
//  BigProjectAStoreIpadOS
//
//  Created by 추현호 on 2022/12/27.
//

import SwiftUI

struct ProductInventoryView: View {
    
    @State private var currentIndex = 0
    @State private var sampleArr = sampleData
    @State private var isTapped = false
    @State private var productCategories = [ "상품명", "상품코드", "옵션", "재고", "수정" ]
    
    let columns = [
        GridItem(.flexible(),alignment: .center),
        GridItem(.flexible(),alignment: .center),
        GridItem(.flexible(),alignment: .center),
        GridItem(.flexible(),alignment: .center),
        GridItem(.flexible(),alignment: .center)
    ]
    
    var body: some View {
        VStack(){
            Text("상품 조회/수정")
                .font(.largeTitle)
            Divider()
            productStatusBar
            Divider()
                
            // MARK: - 상품목록 View
            VStack(alignment: .leading){
                Text("상품 목록 (총 0개)")
                    .font(.title2)
                    .padding()
                Divider()
                // 상품목록 Table
                ScrollView(.vertical){
                    LazyVGrid(columns: columns) {
                        Group{
                            ForEach(productCategories, id: \.self ) { category in
                                Text("\(category)")
                            }
                        }
                        .font(.headline)
                        ForEach(sampleArr.indices, id: \.self) { index in
                            Text(sampleArr[index].productName)
                            Text(sampleArr[index].productId)
                            Text(sampleArr[index].productPrice)
                            Text("\(sampleArr[index].productCount)")
                            Button {
                                currentIndex = index
                                isTapped.toggle()
                            } label: {
                                Text("수정")
                            }
                        }
                        .sheet(isPresented: $isTapped){
                            ProductModifyView(index: $currentIndex)
                        }
                        .padding()
                    }
                }
                    
 
            }
            Spacer()
            Spacer()
        }
    }
}
extension ProductInventoryView{
    
    // 품절, 전체, 판매중 상태
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
                        Text("\(sampleData.count)")                            .font(.title2) + Text("건")
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

