//
//  EditStoreView.swift
//  BigProjectAStoreIpadOS
//
//  Created by 이주희 on 2022/12/27.
//

import SwiftUI
import PhotosUI

struct EditStoreView: View {
    @State var storeImage = ""
    @State var storeName = "멋사 전자 스토어"
    @State var storeAddress = "경기도 네드시 튜나로 12길 27"
    @State var selectedItem: PhotosPickerItem? = nil
    @State var selectedImageData: Data? = nil
    
    var body: some View {
        
            List {
                Section {
                    HStack(alignment: .top) {
                        Text("프로필 사진")
                            .padding(.trailing, 50)
                        VStack {
//                            Circle()
//                                .frame(width: 100)
                            if let selectedImageData,
                               let uiImage = UIImage(data: selectedImageData) {
                                Image(uiImage: uiImage)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 100, height: 100)
                                    .clipShape(Circle())
                            }
                            // TODO: Photo Picker 추가하기
                            PhotosPicker(
                                    selection: $selectedItem,
                                    matching: .images,
                                    photoLibrary: .shared()) {
                                        Text("수정")
                                    }
                                    .onChange(of: selectedItem) { newItem in
                                        Task {
                                            if let data = try? await newItem?.loadTransferable(type: Data.self) {
                                                selectedImageData = data
                                            }
                                        }
                                    }
                        }
//                        Image(storeImage)
//                            .resizable()
//                            .frame(width: 100, height: 100)
//                            .clipShape(Circle())
                    }.padding()
                    
                    
                    HStack {
                        Text("스토어명")
                            .padding(.trailing, 80)
                        Text("\(storeName)")
                            .padding(.trailing, 10)
                        Button {
                            print("")
                        } label: {
                            Text("수정")
                        }

                            
                    }.padding()
                    
                    HStack {
                        Text("사업장소재지")
                            .padding(.trailing, 50)
                        Text("\(storeAddress)")
                            .padding(.trailing, 10)
                        Button {
                            print("")
                        } label: {
                            Text("수정")
                        }
                            
                    }.padding()
                    
                } header: {
                    Text("스토어 정보")
                }
                
            }
            .navigationTitle("List Style")
            // This is the only difference.
            .listStyle(.insetGrouped)
        
//        .listStyle(.plain)
    }
}

struct EditStoreView_Previews: PreviewProvider {
    static var previews: some View {
        EditStoreView().previewInterfaceOrientation(.landscapeRight)
    }
}
