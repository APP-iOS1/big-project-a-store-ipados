//
//  OpenStoreView.swift
//  BigProjectAStoreIpadOS
//
//  Created by 이주희 on 2022/12/28.
//

import SwiftUI
import FirebaseFirestore
import FirebaseAuth

struct OpenStoreView: View {
    @State var storeName = ""
    @State var storeAddress = ""
    @State var phoneNumber = ""
    @Binding var haveStore: Bool
    @EnvironmentObject var storeNetworkManager: StoreNetworkManager
    
    var body: some View {
        VStack {
            List {
                Section {
                    HStack(alignment: .top) {
                        Text("스토어 이름")
                            .modifier(contentNameModifier())
                        TextField("2~14자 내로 입력해주세요", text: $storeName)
                            .modifier(contentFieldModifier())
                    }
                    HStack(alignment: .top) {
                        Text("사업장소재지 주소")
                            .modifier(contentNameModifier())
                        TextField("주소를 입력해주세요", text: $storeAddress)
                            .modifier(contentFieldModifier())
                    }
                    HStack(alignment: .top) {
                        Text("연락처")
                            .modifier(contentNameModifier())
                        TextField("휴대폰 번호를 - 빼고 입력해주세요", text: $phoneNumber)
                            .keyboardType(.numberPad)
                            .modifier(contentFieldModifier())
                    }
                } header: {
                    Text("입점 신청")
                }
                
                Section {
                    HStack {
                        Button {
                            Task{
                                // TODO: CreateStoreInfo
                                // TODO: User 정보(Email) read 해야함.
                                await storeNetworkManager.createStoreInfo(with: StoreInfo(storeId: Auth.auth().currentUser?.uid ?? "", storeEmail: storeNetworkManager.currentStoreUserInfo?.storeEmail ?? "", registerDate: Date.getKoreanNowTimeString(), reportingCount: 0))
                                await storeNetworkManager.updateStoreInfo(with: Auth.auth().currentUser?.uid, by: .isSubmitted(value: true))
                            }
                            haveStore = !((storeNetworkManager.currentStoreUserInfo?.isSubmitted) != nil)
                        } label: {
                            Text("신청하기")
                        }.buttonStyle(PlainButtonStyle())
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                            .foregroundColor(.accentColor)
                        
                    }
                }.listRowBackground(Color.clear)
            }
            
        }
        .textInputAutocapitalization(.never)
        .autocorrectionDisabled()
    }
}

struct contentNameModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(5)
            .frame(width: 180, alignment: .leading)
    }
}

struct contentFieldModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(10)
            .border(.gray)
            .padding(5)
    }
}

//struct OpenStoreView_Previews: PreviewProvider {
//    static var previews: some View {
//        OpenStoreView(isShownFullScreenCover: true)
//    }
//}
