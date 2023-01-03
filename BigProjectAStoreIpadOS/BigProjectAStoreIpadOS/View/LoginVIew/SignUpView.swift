//
//  SignUpView.swift
//  BigProjectAStoreIpadOS
//
//  Created by 이주희 on 2022/12/28.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore

struct SignUpView: View {
    @State private var userID = ""
    @State private var userPassword = ""
    @State private var userPasswordCorrect = ""
    @State private var showingAlert = false
    @State private var isIDChecked = false
    @State private var isNameChecked = false
    @State private var isPasswordChecked = false
    @State private var isSignUpChecked = false
    @State private var signupTest = false
    @Environment(\.dismiss) private var dismiss
    
    @StateObject var signUpViewModel: SignUpViewModel = SignUpViewModel()
    
    var body: some View {
        VStack() {
            List {
                // MARK: 아이디 입력
                Section {
                    HStack(alignment: .top) {
                        Text("아이디")
                            .modifier(contentNameModifier())
                        VStack(alignment: .leading) {
                            TextField("이메일을 입력해주세요", text: $userID)
                                .keyboardType(.emailAddress)
                                .modifier(contentFieldModifier())
                            HStack() {
                                Button {
                                    Task {
                                        // FIXME: 서버랑 연결 다시 확인
                                        // true : 중복 아님
//                                        isIDChecked = await signUpViewModel.isEmailDuplicated(currentUserEmail: userID)
                                        isIDChecked = true
                                    }
                                } label: {
                                    Text("중복검사")
                                        .padding(3)
                                        .background(.blue)
                                        .foregroundColor(.white)
                                }
                                .buttonStyle(PlainButtonStyle())
                                .padding(.horizontal, 10)
                                
                                // FIXME: 아이디 다시 입력할 때 텍스트 떠있는 현상 고치기
                                if isValidEmail(testStr: userID) {
                                    if isIDChecked {
                                        Text("사용 가능한 이메일입니다")
                                            .foregroundColor(.green)
                                    } else {
                                        Text("중복 체크를 해주세요")
                                            .foregroundColor(.red)
                                    }
                                } else {
                                    Text("이메일을 다시 입력해주세요")
                                        .foregroundColor(.red)
                                }
                            }
                        }
                    }
                    // MARK: 비밀번호 입력
                    // FIXME: 비밀번호 정규식 적용
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
//                Section {
//                    HStack(alignment: .top) {
//                        Text("스토어명")
//                            .modifier(contentNameModifier())
//                        VStack(alignment: .leading) {
//                            TextField("스토어 이름을 입력해주세요", text: $storeName)
//                                .modifier(contentFieldModifier())
//                            HStack() {
//                                Button {
//                                    Task {
//                                        // FIXME: 서버랑 연결 다시 확인
//                                        // true : 중복 아님
//                                        isNameChecked = await signUpViewModel.isNicknameDuplicated(currentStoreName: storeName)
//                                    }
//                                } label: {
//                                    Text("중복검사")
//                                        .padding(3)
//                                        .background(.blue)
//                                        .foregroundColor(.white)
//                                }
//                                .buttonStyle(PlainButtonStyle())
//                                .padding(.horizontal, 10)
//
//                                // FIXME: 아이디 다시 입력할 때 텍스트 떠있는 현상 고치기
//                                if isNameChecked {
//                                    Text("사용 가능한 이름입니다")
//                                } else {
//                                    Text("이름을 다시 입력해주세요")
//                                }
//                            }
//                        }
//                    }
//
//                    HStack(alignment: .top) {
//                        Text("사업장소재지")
//                            .modifier(contentNameModifier())
//                        TextField("스토어 주소를 입력해주세요", text: $storeLocation)
//                            .modifier(contentFieldModifier())
//                    }
//
//                    HStack(alignment: .top) {
//                        Text("연락처")
//                            .modifier(contentNameModifier())
//                        TextField("휴대폰 번호를 - 빼고 입력해주세요", text: $phoneNumber)
//                            .keyboardType(.numberPad)
//                            .modifier(contentFieldModifier())
//                    }
//                } header: {
//                    Text("판매자 정보")
//                }
                
                Section {
                    HStack {
                        // TODO: 서버랑 연결해서 회원가입 정보 넘겨주기
                        Button {
                            Task {
                                // FIXME: 
                                if (isIDChecked == true) && (isValidEmail(testStr: userID) == true) && (userPassword.count >= 6) && (userPassword != "" && userPassword == userPasswordCorrect) {
                                    isSignUpChecked = true
                                    signupTest = await signUpViewModel.createUser(email: userID, password: userPassword, nickname: "찌리릿")
                                    
                                    print(signupTest)
                                }
                            }
                            showingAlert = true
                        } label: {
                            Text("가입하기")
                        }.buttonStyle(PlainButtonStyle())
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                            .foregroundColor(.accentColor)
                            .alert(isSignUpChecked ? "회원가입 완료" : "주의", isPresented: $showingAlert) {
                                Button("Ok") { if isSignUpChecked {dismiss()} }
                            } message: {
                                isSignUpChecked ? Text("가입을 환영합니다") : Text("정보를 다시 확인해주세요")
                            }
                        
                    }
                }.listRowBackground(Color.clear)
            }
            
        }
        .textInputAutocapitalization(.never)
        .autocorrectionDisabled()
    }
    
    func isValidEmail(testStr: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
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
