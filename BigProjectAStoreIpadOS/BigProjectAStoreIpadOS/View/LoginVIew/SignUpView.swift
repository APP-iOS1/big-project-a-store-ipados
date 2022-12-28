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
    @State private var isPasswordChecked = false
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack() {
            List {
                // MARK: 아이디 입력
                Section {
                    HStack(alignment: .top) {
                        Text("아이디")
                            .modifier(contentNameModifier())
                        VStack(alignment: .leading) {
                            TextField("4자 이상 / 영문, 숫자 외 문자 금지", text: $userID)
                                .modifier(contentFieldModifier())
                            HStack() {
                                Button {
                                    isIDChecked = true
                                } label: {
                                    Text("중복검사")
                                        .padding(3)
                                        .background(.blue)
                                        .foregroundColor(.white)
                                }
                                .buttonStyle(PlainButtonStyle())
                                .padding(.horizontal, 10)
                                
                                // FIXME: 아이디 다시 입력할 때 텍스트 떠있는 현상 고치기
                                if isIDChecked {
                                    if userID.count >= 4 {
                                        Text("사용 가능한 아이디입니다")
                                            .foregroundColor(.green)
                                    } else {
                                        Text("아이디를 다시 확인해주세요")
                                            .foregroundColor(.red)
                                    }
                                }
                            }
                        }
                    }
                    // MARK: 비밀번호 입력
                    HStack(alignment: .top) {
                        Text("비밀번호")
                            .modifier(contentNameModifier())
                        VStack(alignment: .leading) {
                            TextField("6자 이상 / 영문, 숫자, 특수문자 포함", text: $userPassword)
                                .modifier(contentFieldModifier())
                            if userPassword.count >= 6 {
                                Text("사용가능한 비밀번호입니다")
                                    .padding(.leading, 10)
                                    .foregroundColor(.green)
                                
                            } else if userPassword.count < 6 && userPassword.count > 0 {
                                Text("비밀번호를 6자리이상 입력해주세요")
                                    .padding(.leading, 10)
                                    .foregroundColor(.red)
                            }
                        }
                    }
                    // MARK: 비밀번호 확인
                    HStack(alignment: .top) {
                        Text("비밀번호 확인")
                            .modifier(contentNameModifier())
                        VStack(alignment: .leading) {
                            TextField("비밀번호를 정확하게 입력해주세요", text: $userPasswordCorrect)
                                .modifier(contentFieldModifier())
                            HStack() {
                                if userPassword != "" && userPassword == userPasswordCorrect {
                                    Text("비밀 번호가 일치합니다")
                                        .padding(.leading, 10)
                                        .foregroundColor(.green)
                                } else {
                                    Text("비밀 번호가 일치하지 않습니다")
                                        .padding(.leading, 10)
                                        .foregroundColor(.red)
                                }
                            }
                        }
                    }
                } header: {
                    Text("아이디/패스워드")
                }
                // MARK: 판매자 정보 입력
                Section {
                    HStack(alignment: .top) {
                        Text("판매자명")
                            .modifier(contentNameModifier())
                        TextField("성함을 입력해주세요", text: $userName)
                            .modifier(contentFieldModifier())
                    }
                    // TODO: 이메일 형식 확인
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
                        TextField("휴대폰 번호를 - 빼고 입력해주세요", text: $userPhoneNum)
                            .keyboardType(.numberPad)
                            .modifier(contentFieldModifier())
                    }
                } header: {
                    Text("판매자 정보")
                }
                
                // FIXME: 정보가 완벽하지 않은데 가입으로 넘어가는 현상 고치기
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
        .textInputAutocapitalization(.never)
        .autocorrectionDisabled()
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
