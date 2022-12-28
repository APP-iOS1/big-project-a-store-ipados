//
//  ProjectRegisterView.swift
//  BigProjectAStoreIpadOS
//
//  Created by 추현호 on 2022/12/27.
//

import SwiftUI
import PhotosUI

//사용자가 옵션 작성시 언더바까지 입력했을 때


struct ProductRegisterView: View {
    //상품명
    @State private var productName: String = ""
    //상품 카테고리
    @State private var productCategory: String = ""
    //옵션(현재는 더미데이터)
    @State private var productOption: [String:[String]] = ["램추가":["8GB_10000","16GB_20000"],"SSD추가":["256GB_10000","512GB_20000"]]
    //텍스트필드1번 - 옵션을 입력받음
    @State private var textFieldOptionName: String = ""
    //텍스트필드 2번 - 옵션의 정보를 입력받음
    @State private var textFieldOptionDetails: String = ""
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
    
    //옵션텍스트 변환 함수
    private func convertTextLogic() {
        let convertTextStep1 = textFieldOptionDetails.replacingOccurrences(of: " ", with: "_")
        let convertTextStep2 = convertTextStep1.components(separatedBy: ",")
        if productOption.keys.contains(textFieldOptionName) {
            productOption.updateValue(productOption[textFieldOptionName]! + convertTextStep2, forKey: textFieldOptionName)
        } else {
            productOption[textFieldOptionName] = convertTextStep2
        }
        print(productOption)
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
                        ForEach(Array(productOption.keys.enumerated()), id: \.element) { _, key in
                            if let productOptionKey = productOption[key] {
                                ForEach(productOptionKey.indices, id: \.self) { i in
                                    Text("[\(key)] \(productOptionKey[i])")
                                }
                            }
                        }
                        
                        HStack(spacing: 20) {
                            TextField("[옵션명 작성]", text: $textFieldOptionName)
                                .padding(.horizontal, 20)
                                .frame(maxWidth: 250)
                            TextField("예시: 8기가 10000원,16기가 2만원", text: $textFieldOptionDetails)
                                .padding(.horizontal, 20)
                                .frame(maxWidth: .infinity)
                            Button("추가") { convertTextLogic() }
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

