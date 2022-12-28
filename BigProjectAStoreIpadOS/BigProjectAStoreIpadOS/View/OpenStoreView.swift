//
//  OpenStoreView.swift
//  BigProjectAStoreIpadOS
//
//  Created by 이주희 on 2022/12/28.
//

import SwiftUI

struct OpenStoreView: View {
    @State private var userName = ""
    @State private var userEmail = ""
    @State private var userPhoneNum = ""
    @State var storeName = ""
    @State var storeAddress = ""
    @Binding var isShownFullScreenCover: Bool
    
    var body: some View {
        VStack() {
            List {
                Section {
                    HStack(alignment: .top) {
                        Text("판매자명")
                            .modifier(contentNameModifier())
                        TextField("성함을 입력해주세요", text: $userName)
                            .modifier(contentFieldModifier())
                    }
                    HStack(alignment: .top) {
                        Text("이메일")
                            .modifier(contentNameModifier())
                        TextField("이메일을 입력해주세요", text: $userEmail)
                            .modifier(contentFieldModifier())
                    }
                    HStack(alignment: .top) {
                        Text("연락처")
                            .modifier(contentNameModifier())
                        TextField("휴대폰 번호를 입력해주세요", text: $userPhoneNum)
                            .modifier(contentFieldModifier())
                    }
                } header: {
                    Text("판매자 정보")
                }
                
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
                } header: {
                    Text("입점 신청")
                }
                
                Section {
                    HStack {
                        Button {
                            self.isShownFullScreenCover = false
                        } label: {
                            Text("신청하기")
                        }.buttonStyle(PlainButtonStyle())
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                            .foregroundColor(.accentColor)
                        
                    }
                }.listRowBackground(Color.clear)
            }
            
        }
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
