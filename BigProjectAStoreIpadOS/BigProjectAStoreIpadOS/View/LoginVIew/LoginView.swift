//
//  LoginView.swift
//  BigProjectAStoreIpadOS
//
//  Created by 이주희 on 2022/12/28.
//

import SwiftUI
import FirebaseAuth

struct LoginView: View {
    @State private var userID = ""
    @State private var userPassword = ""
    @Binding var haveStore: Bool
    @Binding var isLoggedin: Bool
    @StateObject var signUpViewModel: SignUpViewModel = SignUpViewModel()
    @StateObject var storeNetworkManager: StoreNetworkManager = StoreNetworkManager()
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("아이디", text: $userID)
                    .textCase(.lowercase)
                    .disableAutocorrection(true)
                    .modifier(LoginFieldModifier())
                
                SecureField("비밀번호", text: $userPassword)
                    .modifier(LoginFieldModifier())
                    .padding(.bottom, 30)
                
                Button {
                    Task {
                        // isSubmitted, isLoggedin 기본값이 false
                        isLoggedin = !(await signUpViewModel.requestUserLogin(withEmail: userID, withPassword: userPassword))
                        // 스토어 승인여부 가져와서 입점신청뷰로 넘어갈지 말지 지정해줌
                        haveStore = !((storeNetworkManager.currentStoreUserInfo?.isSubmitted) != nil)
                        print(isLoggedin)
                        print(haveStore)
                    }
                } label: {
                    Text("로그인")
                        .foregroundColor(.white)
                        .frame(width: 430, height: 50)
                        .background(.blue)
                        .padding(.bottom, 30)
                }
                
                HStack {
                    NavigationLink {
                        SignUpView()
                    } label: {
                        Text("회원가입")
                    }.padding(.trailing, 30)
                    
                    NavigationLink {
                    } label: {
                        Text("ID/PW 찾기")
                    }
                }
            }
            .textInputAutocapitalization(.never)
            .autocorrectionDisabled()
        }
    }
    
}


struct LoginFieldModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(width: 400)
            .padding()
            .border(.gray)
    }
}

//struct LoginView_Previews: PreviewProvider {
//    static var previews: some View {
//        LoginView()
//    }
//}
