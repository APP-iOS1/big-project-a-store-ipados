//
//  ProjectRegisterView.swift
//  BigProjectAStoreIpadOS
//
//  Created by 추현호 on 2022/12/27.
//

import FirebaseAuth
import PhotosUI
import SwiftUI

//사용자가 옵션 작성시 언더바까지 입력했을 때


struct ProductRegisterView: View {
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
    
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var storeNetworkManager: StoreNetworkManager
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
                ZStack {
                        Text("이미지 업로드")
                            .font(.system(size: 70))
                            .foregroundColor(.black)
                            .opacity(0.2)
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 200, trailing: 0))
                        Image(systemName: "plus")
                            .font(.title)
                            .fontWeight(.black)
                            .frame(width:550, height: 550)
                            .background(.gray)
                            .opacity(0.2)
                }

                
            }
            .onChange(of: selectedItem) { newItem in
                Task {
                    if let data = try? await newItem?.loadTransferable(type: Data.self) {
                        selectedImageData = data
                        if let selectedImageData, let uiImage = UIImage(data:selectedImageData){
                            photoArray.append(uiImage)
                            photoString.append(uiImage.toImageString() ?? "")
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
    
    private func checkProductRegistraion() {
        if !(((productName.isEmpty) && (productCategory.isEmpty)) && (productPrice.isEmpty)) {
            print("성공적으로 등록 될 예정")
            //데이터 통신
            /// - Parameter with: Auth.auth().currentUser.uid
            /// - Parameter item: 새로 생성될 ItemInfo 구조체를 생성 후 아규먼트 전달
      
            let item = ItemInfo(
                itemUid: UUID().uuidString,
                storeId: Auth.auth().currentUser?.uid ?? "test",
                itemName: productName,
                itemCategory: productCategory,
                itemAllOption: ItemOptions(itemOptions: productOption),
                itemImage: photoString,
                price: Double(productPrice) ?? 0.0)
            Task {
                await storeNetworkManager.createNewItem(with: Auth.auth().currentUser?.uid ?? "test", item: item)
//                await storeNetworkManager.createNewItem(with: "Test", item: item)
            }
            //뷰 벗어나는 코드 작성하기
            dismiss()
        }
        else {
            print("무언가 작성하지 않았음")
        }
    }
    
    var body: some View {

            VStack {
                Form {
                    //상품명
                    Section(header: Text("상품명").font(.title)) {
                        TextField("상품명 입력", text: $productName)
                    }
                    //상품 카테고리
                    Section(header: Text("상품카테고리").font(.title)) {
                        TextField("카테고리 입력", text: $productCategory)
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
                }
       
                Button {
                    checkProductRegistraion()
                } label: {
                    Text("상품 등록하기")
                }
            }

            .navigationTitle(Text("상품 등록"))
//            .navigationBarBackButtonHidden(true)
//            .navigationBarItems(leading: <#T##L#>, trailing: <#T##T#>)
    }
}

extension UIImage {
    func toImageString() -> String? {
        let data = self.pngData()
        return data?.base64EncodedString(options: .endLineWithLineFeed)
    }
}

struct ProductRegisterView_Previews: PreviewProvider {
    static var previews: some View {
        ProductRegisterView()
            .environmentObject(NavigationStateManager())
    }
}

