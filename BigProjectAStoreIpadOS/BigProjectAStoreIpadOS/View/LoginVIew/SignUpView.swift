//
//  SignUpView.swift
//  BigProjectAStoreIpadOS
//
//  Created by 이주희 on 2022/12/28.
//

import SwiftUI

struct SignUpView: View {
    @State private var userID = ""
    @State private var userPassword = ""
    @State private var userPasswordCorrect = ""
    @State private var userName = ""
    @State private var userEmail = ""
    @State private var userPhoneNum = ""
    @State private var showingAlert = false
    @State private var isIDChecked = false
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack() {
            List {
                Section {
                    
                    HStack(alignment: .top) {
                        Text("아이디")
                            .modifier(contentNameModifier())
                        VStack {
                            TextField("아이디를 입력해주세요", text: $userID)
                                .modifier(contentFieldModifier())
                            HStack() {
                                Button {
                                    isIDChecked = true
                                } label: {
                                    Text("중복검사")
                                }.buttonStyle(PlainButtonStyle())
                                .padding(.trailing, 10)
                                
                                if isIDChecked {
                                    Text("사용 가능한 아이디입니다")
                                }
                            }
                        }
                    }
                    HStack(alignment: .top) {
                        Text("비밀번호")
                            .modifier(contentNameModifier())
                        TextField("6자 이상 / 영문, 숫자, 특수문자 포함", text: $userPassword)
                            .modifier(contentFieldModifier())
                    }
                    HStack(alignment: .top) {
                        Text("비밀번호 확인")
                            .modifier(contentNameModifier())
                        TextField("6자 이상 / 영문, 숫자, 특수문자 포함", text: $userPasswordCorrect)
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
                            showingAlert = true
                        } label: {
                            Text("가입하기")
                        }.buttonStyle(PlainButtonStyle())
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                            .foregroundColor(.accentColor)
                            .alert("회원가입 완료", isPresented: $showingAlert) {
                                Button("Ok") { dismiss() }
                            } message: {
                                Text("가입을 환영합니다")
                            }
                        
                    }
                }.listRowBackground(Color.clear)
            }
            
        }
    }
}

struct SignUpFieldModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(10)
            .border(.gray)
            .padding(5)
    }
    
    struct SignUpView_Previews: PreviewProvider {
        static var previews: some View {
            SignUpView()
        }
    }
}
