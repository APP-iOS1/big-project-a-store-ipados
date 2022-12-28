//
//  EditStoreView.swift
//  BigProjectAStoreIpadOS
//
//  Created by 추현호 on 2022/12/27.
//


import SwiftUI
import Combine
import PhotosUI

struct EditStoreView: View {
    // TODO: storeName, storeAddress Binding값으로 바꿔주기
    @State private var storeImage = ""
    @State private var storeName = "멋사 전자 스토어"
    @State private var storeAddress = "경기도 네드시 튜나로 12길 27"
    @State private var selectedItem: PhotosPickerItem? = nil
    @State private var selectedImageData: Data? = nil
    @State private var isNameClicked = true
    @State private var isAddressClicked = true
    
    var body: some View {
        
        List {
            Section {
                HStack(alignment: .top) {
                    Text("프로필 사진")
                        .padding(.trailing, 50)
                    VStack {
                        if let selectedImageData,
                           let uiImage = UIImage(data: selectedImageData) {
                            Image(uiImage: uiImage)
                                .resizable()
                                .frame(width: 100, height: 100)
                                .clipShape(Circle())
                        } else {
                            Circle()
                                .frame(width: 100)
                        }
                        
                        PhotosPicker(selection: $selectedItem,
                                     matching: .images,
                                     photoLibrary: .shared()) {
                            Text("수정")
                        }.onChange(of: selectedItem) { newItem in
                            Task {
                                if let data = try? await newItem?.loadTransferable(type: Data.self) {
                                    selectedImageData = data
                                }
                            }
                        }
                    }
                }.padding()
                
                HStack {
                    Text("스토어명")
                        .padding(.trailing, 80)
                    if isNameClicked {
                        Text("\(storeName)")
                            .padding(.trailing, 10)
                    } else {
                        TextField("\(storeName)", text: $storeName)
                            .frame(width: 200)
                            .border(.gray)
                    }
                    
                    Button {
                        isNameClicked.toggle()
                    } label: {
                        Text("수정")
                    }
                    .modifier(EditButtonModifier())
                }.padding()
                
                HStack {
                    Text("사업장소재지")
                        .padding(.trailing, 50)
                    if isAddressClicked {
                        Text("\(storeAddress)")
                            .padding(.trailing, 10)
                    } else {
                        TextField("\(storeAddress)", text: $storeAddress)
                            .frame(width: 300)
                            .border(.gray)
                    }
                    
                    Button {
                        isAddressClicked.toggle()
                    } label: {
                        Text("수정")
                    }
                    .modifier(EditButtonModifier())
                }.padding()
            } header: {
                Text("스토어 정보")
            }
            
        }
    }
}

struct EditButtonModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(.accentColor)
            .buttonStyle(PlainButtonStyle())
        // buttonStyle 안주면 리스트 전체가 버튼으로 눌리는 문제 발생
        
    }
}

struct EditStoreView_Previews: PreviewProvider {
    static var previews: some View {
        EditStoreView().previewInterfaceOrientation(.landscapeRight)
    }
}

