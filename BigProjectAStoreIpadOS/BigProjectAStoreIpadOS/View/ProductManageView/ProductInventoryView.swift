//
//  ProductInventoryView.swift
//  BigProjectAStoreIpadOS
//
//  Created by 추현호 on 2022/12/27.
//

import SwiftUI

struct ProductInventoryView: View {
    
    
    @State private var wideButtonTapped = false
    @State private var currentIndex = 0
    @State private var sampleArr = sampleData
    @State private var isTapped = false
    @State private var startDate = Date()
    @State private var endDate = Date()
    @State private var productCategories = [ "상품명", "상품코드", "카테고리", "재고", "수정" ]
    
    let columns = [
        GridItem(.flexible(),alignment: .center),
        GridItem(.flexible(),alignment: .center),
        GridItem(.flexible(),alignment: .center),
        GridItem(.flexible(),alignment: .center),
        GridItem(.flexible(),alignment: .center)
    ]
    
    var body: some View {
        
        VStack(){
            Divider()
            productStatusBar
            
        // 상품목록 펼쳐보기
        if  !wideButtonTapped {
            // 상품 목록 조회 검색 UI
            VStack(alignment:.leading){
                Divider()
                //[검색 category - 검색어]
                HStack{
                    Text("검색어")
                        .font(.headline)
                    Spacer()
                        .frame(width: 150)
                    
                    VStack(alignment: .leading){
                        
                        HStack{
                            Text("상품명")
                                .font(.title3)
                            TextField("dfsd", text: .constant(""))
                                .textFieldStyle(.roundedBorder)
                                .frame(width: 600)
                        }
                        HStack{
                            Text("상품 코드")
                                .font(.title3)
                            TextField("dfsd", text: .constant(""))
                                .textFieldStyle(.roundedBorder)
                                .frame(width: 600)
                        }
                    }
                }
                .padding(10)
                Divider()
                //[검색 category - 분류]
                HStack{
                    Text("카테고리")
                        .font(.headline)
                }
                .padding(10)
                Divider()
                //[검색 category - 기간]
                HStack{
                    Text("기간")
                        .font(.headline)
                    Spacer()
                    HStack{
                        
                        Text("상품 등록일:")
                            .font(.title3)
                        DatePicker("", selection: $startDate, displayedComponents: [.date])
                            .frame(width: 150)
                        Text("     ~")
                        DatePicker("", selection: $endDate, displayedComponents: [.date])
                            .frame(width: 150)
                    }
                    Spacer()
                }
                .padding(10)
            }
            }
            
            Divider()
            // MARK: - 상품목록 View
            VStack(alignment: .leading){
                HStack{
                    Text("상품 목록 (총 0개)")
                        .font(.title2)
                        .padding()
                    Spacer()
                    Button {
                        wideButtonTapped.toggle()
                    } label: {
                        Image(systemName: !wideButtonTapped ?
                              "arrow.up.to.line.compact" : "arrow.down.to.line.compact")
                    }
                    .padding(.trailing, 40)

                }
                
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
                            Text(sampleArr[index].productCategory)
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
        .navigationTitle("상품 조회/수정")
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
        NavigationStack{
            ProductInventoryView()
        }
    }
}

