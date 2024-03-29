//
//  ProductModifyView.swift
//  BigProjectAStoreIpadOS
//
//  Created by sehooon on 2022/12/27.
//

import SwiftUI
import PhotosUI
import FirebaseAuth

struct ProductModifyView: View {
    
    @Binding var productId: String
    
    @EnvironmentObject private var storeNetworkManager: StoreNetworkManager
    @Environment(\.editMode) private var editMode
    @Environment(\.dismiss) private var dismiss
    @State private var disableEdit = true
    @State private var editAlert = false
    
    @State private var productIndex = 0
    //상품명
    @State private var productName: String = ""
    //상품 카테고리
    @State private var productCategory: String = ""
    //상품 가격
    @State private var productPrice: String = ""
    //옵션
    @State private var productOption: [String:[String]] = [:]
    //텍스트필드1번 - 옵션을 입력받음
    @State private var textFieldOptionName: String = ""
    //텍스트필드 2번 - 옵션의 정보를 입력받음
    @State private var textFieldOptionDetails: String = ""
    //판매자 등록화면에서 볼 수 있는 상품이미지
    @State private var photoArray: [UIImage] = []
    //Firebase에 올라가는 String형태의 이미지
    @State private var photoString: [String] = []
    
    //Use PhotosUI
    @State private var selectedItem: PhotosPickerItem? = nil
    @State private var selectedImageData: Data? = nil
    
    
    
    
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
                    
                    //상품 가격
                    Section(header: Text("가격").font(.title)) {
                        TextField("상품 가격 입력", text: $productPrice)
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
                            Button("추가") {
                                if !textFieldOptionDetails.isEmpty {
                                    convertTextLogic()
                                }
                                
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
                                        .frame(width: 550, height: 550)
                                }
                                Spacer()
                                photoLogic()
                            }
                        }
                    }
                    .navigationTitle(Text("상품 수정"))
                }
                .toolbar{
                    ToolbarItem(id: "trailing") {
                        Button {
                            if !disableEdit {
                                
                                disableEdit.toggle()
                            }else{
                                editAlert.toggle()
                                disableEdit.toggle()
                            }
                        } label: {
                            Text("Done")
                        }
                    }
                }
                .onAppear{
                    // 선택한 상품 찾아서 화면에 출력
                    for index in storeNetworkManager.currentStoreItemArray.indices{
                        if storeNetworkManager.currentStoreItemArray[index].itemUid == productId {
                            productIndex = index
                            productCategory = storeNetworkManager.currentStoreItemArray[index].itemCategory
                            productName = storeNetworkManager.currentStoreItemArray[index].itemName
                            productPrice = String(storeNetworkManager.currentStoreItemArray[index].price)
                            productOption = storeNetworkManager.currentStoreItemArray[index].itemAllOption.itemOptions
                            break
                        }
                    }
                }
            }
            .alert("저장하시겠습니까?", isPresented: $editAlert){
                Button("아니요"){
                    dismiss()
                }
                Button ("네"){
                    Task
                    {
                        // 변경사항 파이어베이스 반영.
                        storeNetworkManager.currentStoreItemArray[productIndex].itemName = productName
                        storeNetworkManager.currentStoreItemArray[productIndex].itemCategory = productCategory
                        storeNetworkManager.currentStoreItemArray[productIndex].price =  Double(productPrice) ?? 0.0
                        
                        let item = ItemInfo(
                            itemUid: storeNetworkManager.currentStoreItemArray[productIndex].itemUid,
                            storeId: storeNetworkManager.currentStoreItemArray[productIndex].storeId,
                            itemName: storeNetworkManager.currentStoreItemArray[productIndex].itemName,
                            itemCategory: storeNetworkManager.currentStoreItemArray[productIndex].itemCategory,
                            itemAllOption: ItemOptions(itemOptions: productOption),
                            itemImage: ["test"],
                            price: storeNetworkManager.currentStoreItemArray[productIndex].price)
                        await storeNetworkManager.createNewItem(with: Auth.auth().currentUser?.uid, item: item)
                        dismiss()
                    }
                }
            } message:{
                Text("기존에 있던 내용들이 수정됩니다.")
            }
            
        }
        
        //옵션텍스트 변환 함수
    }
}

struct ProductModifyView_Previews: PreviewProvider {
    static var previews: some View {
        ProductModifyView(productId: .constant(""))
            .environmentObject(NavigationStateManager())
    }
}
