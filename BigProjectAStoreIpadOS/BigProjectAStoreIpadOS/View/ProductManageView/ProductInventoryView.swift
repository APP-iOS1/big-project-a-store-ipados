//
//  ProductInventoryView.swift
//  BigProjectAStoreIpadOS
//
//  Created by 추현호 on 2022/12/27.
//

import SwiftUI
import FirebaseAuth

struct ProductInventoryView: View {
    
    @EnvironmentObject private var storeNetworkManager: StoreNetworkManager
    @State private var wideButtonTapped = false // 상품목록 펼치기
    @State private var currentIndex = 0 // 상품 dataindex
    @State private var productArr:[ItemInfo] =  []
    @State private var isTapped = false // 수정 버튼
    @State private var startDate = Date() // 상품 등록일(1)
    @State private var endDate = Date() // 상품 등록일
    @State private var categorySelect = sampleCategory[0] // 상품 카테고리 선택 피커
    @State private var productName = "" // 상품명
    @State private var productCode = "" // 상품 코드
    
    @State private var deleteTapped = false  // 상품 삭제 alert
    @State private var deleteItemIndex = 0   // 선택 상품 index
    @State private var sortOrder = [KeyPathComparator(\ItemInfo.itemName)]
    
    let columns = [
        GridItem(.flexible(),alignment: .center),
        GridItem(.flexible(),alignment: .center),
        GridItem(.flexible(),alignment: .center),
        GridItem(.flexible(),alignment: .center),
        GridItem(.flexible(),alignment: .center)
    ]
    
    var body: some View {
        NavigationStack{
            VStack{
                Divider()
                // 전체 상품 상태 바
                productStatusBar
                    .navigationTitle("상품 관리")
                // 상품목록 펼쳐보기
                if wideButtonTapped {
                    // 상품 목록 조회 검색 UI
                    VStack(alignment: .leading){
                        Divider()
                        //[검색 category - 검색어]
                        HStack{
                            Text("검색어")
                                .font(.headline)
                                .padding(.leading)
                            Spacer()
                                .frame(width: 150)
                            
                            VStack(alignment: .leading){
                                HStack{
                                    Text("상품명")
                                        .font(.title3)
                                    TextField("ex) 애플워치", text: $productName)
                                        .textFieldStyle(.roundedBorder)
                                        .frame(width: 500)
                                }
                                
                            }
                        }
                        .padding(10)
                        Divider()
                        
                        //[검색 category - 기간]
                        HStack{
                            Text("기간")
                                .padding(.leading)
                                .font(.headline)
                            Spacer()
                            HStack{
                                Text("상품 등록일:")
                                    .font(.title3)
                                
                                DatePicker("", selection: $startDate, displayedComponents: [.date])
                                    .frame(width: 100)
                                
                                Text("     ~")
                                DatePicker("", selection: $endDate, displayedComponents: [.date])
                                    .frame(width: 100)
                            }
                            Spacer()
                        }
                        .padding(10)
                        Divider()
                        
                        HStack(alignment: .center){
                            Spacer()
                            HStack(spacing: 50){
                                Button {
                                    productArr = storeNetworkManager.currentStoreItemArray.filter {
                                        return $0.itemName == productName
                                    }
                                } label: {
                                    Text("검색")
                                        .font(.title3)
                                }
                                Button {
                                    productArr = storeNetworkManager.currentStoreItemArray
                                } label: {
                                    Text("초기화")
                                        .font(.title3)
                                }
                                Button {
                                    withAnimation{
                                        wideButtonTapped = false
                                    }
                                } label: {
                                    Text("검색창 닫기")
                                        .font(.title3)
                                }
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
                        Text("상품 목록 (총 \(productArr.count)개)")
                            .font(.title2)
                            .padding()
                        Spacer()
                        Button {
                            withAnimation {
                                wideButtonTapped = true
                            }
                        } label: {
                            HStack{
                                Text("상품검색")
                                Image(systemName: "magnifyingglass")
                            }
                        }
                        .padding(.trailing, 40)
                        NavigationLink {
                            ProductRegisterView()
                                .onDisappear{
                                        productArr = storeNetworkManager.currentStoreItemArray
                                }
                        } label: {
                            HStack{
                                Text("상품추가")
                                Image(systemName: "plus")
                                
                            }
                        }
                        .padding(.trailing, 40)
                    }
                    
                    Divider()
                    // 상품목록 Table
                    Table(productArr, sortOrder: $sortOrder){
                        TableColumn("상품명", value: \.itemName)
                        TableColumn("카테고리", value: \.itemCategory){ product in
                            Text("\(product.itemCategory)")
                        }
                        
                        TableColumn("가격", value: \.price){ product in
                            Text("\(product.price)")
                        }
                        
                        TableColumn("수정"){ product in
                            Button {
                                isTapped.toggle()
                                productCode = product.itemUid
                            } label: {
                                Text("상품 수정")
                                    .foregroundColor(.black)
                                    .padding(5)
                                    .overlay(Rectangle()
                                        .stroke(Color.black, lineWidth:0.5))
                            }
                            
                        }
                        
                        TableColumn("삭제"){ product in
                            Button {
                                productCode = product.itemUid
                                // 해당 등록 상품 삭제
                                deleteTapped.toggle()
                            } label: {
                                Text("삭제")
                                    .foregroundColor(.red)
                            }
                        }
                        
                    }
                    .onAppear{
                        Task{
                            await storeNetworkManager.requestItemInfo(with: Auth.auth().currentUser?.uid)
                            productArr = storeNetworkManager.currentStoreItemArray
                        }
                    }
                    .alert("삭제하시겠습니까?", isPresented: $deleteTapped){
                        Button("아니요"){
                        }
                        Button ("네"){
                            Task{
                                await storeNetworkManager.removeItem(from: Auth.auth().currentUser?.uid, withItemUid: productCode)
                                await storeNetworkManager.requestItemInfo(with: Auth.auth().currentUser?.uid)
                                productArr = storeNetworkManager.currentStoreItemArray
                            }
                        }
                    } message:{
                        Text("해당 상품이 목록에서 제거됩니다.")
                    }
                    .fullScreenCover(isPresented: $isTapped, content: {
                        ProductModifyView(productId: $productCode)
                            .onDisappear{
                                productArr = storeNetworkManager.currentStoreItemArray
                            }
                    })
                    .onChange(of: sortOrder) { newOrder in
                        productArr.sort(using: newOrder)
                    }
                    
                    
                }
                Spacer()
            }
 
            
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
                        Text("\(sampleData.count)")
                            .font(.title2) + Text("건")
                    }
                    .padding()
                }
                
                HStack{
                    Image(systemName: "cart.fill.badge.minus")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50,height: 50)
                    VStack(alignment: .leading){
                        Text("품절")
                        Text("0 ")
                            .font(.title2) + Text("건")
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
                        Text("\(sampleData.count)")
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
                .environmentObject(StoreNetworkManager())
        }
    }
}

