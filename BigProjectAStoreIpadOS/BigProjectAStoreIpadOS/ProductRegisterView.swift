//
//  ProductRegisterView.swift
//  StoreChallenge
//
//  Created by kimminho on 2022/12/27.
//
//                .listStyle(.sidebar)

import SwiftUI

struct ProductRegisterView: View {
    @State private var productName: String = ""
    @State private var productOption: [String:Int] = ["화이트":1,"블랙":2,"그레이":1]
    @State private var textFieldOptionColor: String = ""
    @State private var textFieldOptionCount: String = ""
    @State private var productDescription: String = ""
    
//    func removeRows(at offsets: IndexSet) {
//        productOption.remove(at: offsets)
//    }
    var body: some View {
        NavigationStack {
            VStack {
                Form {
                    Section(header: Text("상품명").font(.title)) {
                        TextField("", text: $productName)
                    }
                    Section(header: Text("상품카테고리").font(.title)) {
                        TextField("", text: $productName)
                    }
                    Section(header: Text("옵션").font(.title)) {
                        ForEach(productOption.sorted(by: >), id:\.key) {key, value  in
                            HStack {
                                Text("색상: \(key)")
                                Text("수량: \(value)개")
                            }
                            
                        }
//                        .onDelete(perform: removeRows)
                        
                        HStack(spacing: 20) {
                            TextField("색상", text: $textFieldOptionColor)
                                .padding(.horizontal, 20)
                                .frame(maxWidth: .infinity)
                            TextField("수량", text: $textFieldOptionCount)
                                .padding(.horizontal, 20)
                                .frame(maxWidth: .infinity)
                            Button {
//                                productOption.append(<#String#>)

                            } label: {
                                Text("추가")
                            }

                        }
                    }
                    Section(header: Text("상품이미지").font(.title)) {
                        HStack{
                            //오후: 상품이미지 받는 배열하나 만들기
                            Rectangle().frame(width: 200, height:200)
                            Rectangle().frame(width: 200, height:200)
                            Rectangle().frame(width: 200, height:200)

                            Spacer()
                            Button {
                                
                            } label: {
                                //아이콘넣기
                                Text("+").font(.title)
                            }

                        }
                    }
                    Section(header: Text("상품설명").font(.title)) {
                        TextEditor(text: $productDescription)
                            .frame(height:200)

                    }
                }
                .navigationTitle(Text("상품 등록"))
                Button {
                    
                } label: {
                    Text("등록하기")
                }
            }
        }
    }
}

struct ProductRegisterView_Previews: PreviewProvider {
    static var previews: some View {
        ProductRegisterView()
    }
}
