//
//  ProductModifyView.swift
//  BigProjectAStoreIpadOS
//
//  Created by sehooon on 2022/12/27.
//

import SwiftUI
import PhotosUI

struct ProductModifyView: View {
    
    @Binding var index: Int
    
    @Environment(\.editMode) private var editMode
    @Environment(\.dismiss) private var dismiss
    @State private var disableEdit = true
    //상품명
    @State private var productName: String = ""
    @State private var productCategory: String = ""
    //옵션(현재는 더미데이터)
    @State private var productOption: [String:[String]] = ["램추가":["8GB_10000","16GB_20000"],"SSD추가":["256GB_10000","512GB_20000"]]
    
    //텍스트필드1번 - 옵션을 입력받음
    @State private var textFieldOption: String = ""
    @State private var textFieldOptionDetails: String = ""
    @State private var splitText = ""
    //상품 설명
    @State private var productDescription: String = ""
    
    //Use PhotosUI
    @State private var selectedItem: PhotosPickerItem? = nil
    @State private var selectedImageData: Data? = nil
    //상품이미지
    @State private var photoArray: [UIImage] = []
    
    @State private var editAlert = false

    
    
//    //Delete Option
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
            .disabled(disableEdit)
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
    private func convertTextLogic() {
        let convertTextStep1 = textFieldOptionDetails.replacingOccurrences(of: " ", with: "_")
        let convertTextStep2 = convertTextStep1.components(separatedBy: ",")
        if productOption.keys.contains(textFieldOption) {
            productOption.updateValue(productOption[textFieldOption]! + convertTextStep2, forKey: textFieldOption)
        } else {
            productOption[textFieldOption] = convertTextStep2
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
                            .disabled(disableEdit)
                    }
                    //상품 카테고리
                    Section(header: Text("상품카테고리").font(.title)) {
                        TextField("", text: $productCategory)
                            .disabled(disableEdit)
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
                            TextField("[옵션명 작성]", text: $textFieldOption)
                                .padding(.horizontal, 20)
                                .frame(maxWidth: 250)
                            TextField("[세부내용 작성작성] ex)8기가 10000원,16기가 2만원", text: $textFieldOptionDetails)
                                .padding(.horizontal, 20)
                                .frame(maxWidth: .infinity)
                            Button("추가") { convertTextLogic() }
                        }
                    }
                    //상품 이미지
                    Section(header: Text("상품이미지").font(.title)) {
                        ScrollView(.horizontal) {
                            HStack{
                                ForEach(photoArray.indices,id:\.self) { index in
                                    ZStack{
                                        Image(uiImage: photoArray[index])
                                            .resizable()
                                            .frame(width: 200, height: 200)
                                        Button {
                                            photoArray.remove(at:index)
                                        } label: {
                                            Image(systemName: "minus.circle.fill")
                                                .foregroundColor(.red)
                                        }
                                        .offset(x: 80 ,y:-80)
                                    }
                                    
                                }
//                                .onDelete {}
                                Spacer()
                                photoLogic()
                            }
                        }
                        
                    }
                    //상품 설명
                    Section(header: Text("상품설명").font(.title)) {
                        TextEditor(text: $productDescription)
                            .frame(height:200)
                            .disabled(disableEdit)
                    }
                }
            
                .navigationTitle(Text("상품 수정"))

            }
            .toolbar{
                
                ToolbarItem() {
                    Button {
                        dismiss()
                    } label: {
                        Text("Back")
                    }

                }
                
                ToolbarItem(id: "trailing") {
                    Button {
                        if !disableEdit {
                            editAlert.toggle()
                            disableEdit.toggle()
                        }else{
                            disableEdit.toggle()
                        }
                        

                    } label: {
                        Text(disableEdit ? "Edit" : "Done")
                    }
                    

                }
            }
            .onAppear{
                productName = sampleData[index].productName
                productCategory = sampleData[index].productId
            }
        }
        .alert("저장하시겠습니까?", isPresented: $editAlert){
            Button("아니요"){}
            Button ("네"){}
        } message:{
            Text("기존에 있던 내용들이 수정됩니다.")
        }
        .modifier(CloseUpDetailModifier())
            
    }
    
    //옵션텍스트 변환 함수
    
}

struct ProductModifyView_Previews: PreviewProvider {
    static var previews: some View {
        ProductModifyView(index: .constant(0))
            .environmentObject(NavigationStateManager())
    }
}
