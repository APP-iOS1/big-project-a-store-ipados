//
//  SignUpView.swift
//  BigProjectAStoreIpadOS
//
//  Created by 이주희 on 2022/12/28.
//

import SwiftUI

struct SignUpView: View {
    @State private var userName = ""
    @State private var userEmail = ""
    @State private var userPhoneNum = ""
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack() {
            List {
                Section {
                    HStack(alignment: .top) {
                        Text("아이디")
                            .modifier(contentNameModifier())
                        TextField("아이디를 입력해주세요", text: $userName)
                            .modifier(contentFieldModifier())
                    }
                    HStack(alignment: .top) {
                        Text("비밀번호")
                            .modifier(contentNameModifier())
                        TextField("6자 이상 / 영문, 숫자, 특수문자 포함", text: $userEmail)
                            .modifier(contentFieldModifier())
                    }
                } header: {
                    Text("아이디/패스워드")
                }
                
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
                            .keyboardType(.emailAddress)
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
                    HStack {
                        Button {
                            dismiss()
                        } label: {
                            Text("가입하기")
                        }.buttonStyle(PlainButtonStyle())
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                            .foregroundColor(.accentColor)
                        
                    }
                }.listRowBackground(Color.clear)
            }
            
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
