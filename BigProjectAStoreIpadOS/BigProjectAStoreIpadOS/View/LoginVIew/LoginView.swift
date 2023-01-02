//
//  LoginView.swift
//  BigProjectAStoreIpadOS
//
//  Created by 이주희 on 2022/12/28.
//

import SwiftUI

struct LoginView: View {
    @State var userID = ""
    @State var userPassword = ""
    @State var haveStore = true
    @Binding var isLoggedin: Bool
    
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
                    // FIXME: Auth에서 로그인 상태 가져오기
//                    let loginResult = 
                    isLoggedin = false
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
