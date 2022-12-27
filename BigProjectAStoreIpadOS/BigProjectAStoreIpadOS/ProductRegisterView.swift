//
//  ProductRegisterView.swift
//  StoreChallenge
//
//  Created by kimminho on 2022/12/27.
//

import SwiftUI
import Combine
import PhotosUI

struct ProductRegisterView: View {
    //상품명
    @State private var productName: String = ""
    @State private var productCategory: String = ""
    //옵션(현재는 더미데이터)
    @State private var productOption: [String:Int] = ["화이트":1,"블랙":2,"그레이":1]
    //텍스트필드1번 - 색상을 입력받음
    @State private var textFieldOptionColor: String = ""
    //텍스트필드2번 - 수량을 입력받음
    @State private var textFieldOptionCount: String = ""
    //상품 설명
    @State private var productDescription: String = ""
    
    //Use PhotosUI
    @State private var selectedItem: PhotosPickerItem? = nil
    @State private var selectedImageData: Data? = nil
    //상품이미지
    @State private var photoArray: [UIImage] = []
    
    //Delete Option
    func optionDelete(at offsets: IndexSet){
        if let ndx = offsets.first {
            let item = productOption.sorted(by: >)[ndx]
            productOption.removeValue(forKey: item.key)
        }
    }
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
                    Section(header: Text("상품명").font(.title)) {
                        TextField("", text: $productName)
                    }
                    Section(header: Text("상품카테고리").font(.title)) {
                        TextField("", text: $productCategory)
                    }
                    Section(header: Text("옵션").font(.title)) {
                        ForEach(productOption.sorted(by: >), id:\.key) {key, value  in
                            HStack {
                                Text("색상: \(key)")
                                Text("수량: \(value)개")
                            }
                            
                        }
                        .onDelete(perform: optionDelete)
                        
                        HStack(spacing: 20) {
                            TextField("색상", text: $textFieldOptionColor)
                                .padding(.horizontal, 20)
                                .frame(maxWidth: .infinity)
                            TextField("수량", text: $textFieldOptionCount)
                                .keyboardType(.numberPad)
                                .padding(.horizontal, 20)
                                .frame(maxWidth: .infinity)
                                .onReceive(Just(textFieldOptionCount)) { value in
                                    let filteredCount = value.filter {"0123456789".contains($0)}
                                    if filteredCount != value {
                                        self.textFieldOptionCount = filteredCount
                                    }
                                }
                            Button {
                                productOption.updateValue(Int(textFieldOptionCount)!, forKey: textFieldOptionColor)
                                
                            } label: {
                                Text("추가")
                            }
                            
                        }
                    }
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
