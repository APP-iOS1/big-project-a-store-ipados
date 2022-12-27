//
//  ProjectRegisterView.swift
//  BigProjectAStoreIpadOS
//
//  Created by 추현호 on 2022/12/27.
//

import SwiftUI
import Combine
import PhotosUI

struct ProductRegisterView: View {
    //상품명
    @State private var productName: String = ""
    //상품 카테고리
    @State private var productCategory: String = ""
    //옵션(현재는 더미데이터)
    @State private var productOption: [String:[String]] = ["iphone15":["256_10000","512_20000"]]
    //텍스트필드1번 - 색상을 입력받음
    @State private var textFieldOptionColor: String = ""
    //상품이미지
    @State private var photoArray: [UIImage] = []
    //상품 설명
    @State private var productDescription: String = ""
    
    //Use PhotosUI
    @State private var selectedItem: PhotosPickerItem? = nil
    @State private var selectedImageData: Data? = nil
    //
    //Delete Option
//    func optionDelete(at offsets: IndexSet){
//        if let ndx = offsets.first {
//            let item = productOption.sorted(by: >)[ndx]
//            productOption.removeValue(forKey: item.key)
//        }
//    }
    //사진 입력받는 로직
    func photoLogic() -> some View {
        PhotosPicker(
            selection: $selectedItem,
            matching: .images,
            photoLibrary: .shared()) {
                Image(systemName: "plus")
                    .fontWeight(.black)
                    .frame(width:200, height: 200)
                    .background(.gray)
                    .opacity(0.2)
                
            }
            .onChange(of: selectedItem) { newItem in
                Task {
                    if let data = try? await newItem?.loadTransferable(type: Data.self) {
                        selectedImageData = data
                        if let selectedImageData, let uiImage = UIImage(data:selectedImageData){
                            photoArray.append(uiImage)
                        }
                    }
                }
            }
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                Form {
                    //상품명
                    Section(header: Text("상품명").font(.title)) {
                        TextField("", text: $productName)
                    }
                    //상품 카테고리
                    Section(header: Text("상품카테고리").font(.title)) {
                        TextField("", text: $productCategory)
                    }
                    //상품 옵션
                    Section(header: Text("옵션").font(.title)) {
//                        ForEach(productOption,id:\.self) {value  in
                                HStack {
//                                    Text("색상: \(value2.value)")
//                                    Text("수량: \(value)개")
                                }
                            

                            
//                        }
//                        .onDelete(perform: optionDelete)
                        
                        HStack(spacing: 20) {
                            TextField("색상", text: $textFieldOptionColor)
                                .padding(.horizontal, 20)
                                .frame(maxWidth: .infinity)
                            Button("추가") {
                            }
                        }
                    }
                    //상품 이미지
                    Section(header: Text("상품이미지").font(.title)) {
                        ScrollView(.horizontal) {
                            HStack{
                                ForEach(photoArray,id:\.self) { photo in
                                    Image(uiImage: photo)
                                        .resizable()
                                        .frame(width: 200, height: 200)
                                }
                                Spacer()
                                photoLogic()
                            }
                        }
                        
                    }
                    //상품 설명
                    Section(header: Text("상품설명").font(.title)) {
                        TextEditor(text: $productDescription)
                            .frame(height:200)
                        
                    }
                }
                .navigationTitle(Text("상품 등록"))
                Button {
                    //
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

